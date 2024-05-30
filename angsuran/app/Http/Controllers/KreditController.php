<?php

namespace App\Http\Controllers;

use App\Models\KreditModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\DB;

class KreditController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $kredit = KreditModel::all();

        foreach ($kredit as $k) {
            $angsuranPerBulan = ($k->jumlah_pinjaman * ($k->bunga / 100)) + ($k->jumlah_pinjaman / $k->tenor);
            $k->angsuran_perbulan = $angsuranPerBulan;

            $angsuranTotal = $angsuranPerBulan * $k->tenor;
            $k->angsuran_total = $angsuranTotal;
        }

        return response()->json(['message' => 'Succes', 'data'=> $kredit]);
        //return view('history_kredit')->with('kredit', $kredit);

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $kredit = DB::table('kredit');

        //return view('home_kredit')->with('kredit', $kredit);
        return response()->json(['message' => 'Succes', 'data'=> $kredit]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $kredit = KreditModel::create([
            'nama' => $request->nama,
            'jumlah_pinjaman' => $request->jumlah_pinjaman,
            'tenor' => $request->tenor,
            'bunga' => $request->bunga,
            'bunga_floating' => $request->bunga_floating,
            'angsuran_perbulan' => 0,
            'angsuran_total'=> 0
        ]);
        // Simpan data kredit
        $kredit->save();


        $total_bunga_tambahan = 0;
    for ($i = 1; $i <= $kredit->tenor; $i++) {
        $total_bunga_tambahan += $request->bunga_floating * $i;
    }

    // Hitung ulang total bunga
    $total_bunga = $kredit->bunga + $total_bunga_tambahan;

    // Hitung ulang angsuran per bulan
    $angsuranPerBulan = ($kredit->jumlah_pinjaman * ($total_bunga / 100)) + ($kredit->jumlah_pinjaman / $kredit->tenor);
    $kredit->angsuran_perbulan = $angsuranPerBulan;

    // Hitung ulang total angsuran
    $angsuranTotal = $angsuranPerBulan * $kredit->tenor;
    $kredit->angsuran_total = $angsuranTotal;

    // Simpan kembali data kredit setelah perhitungan
    $kredit->save();

    return response()->json(['message' => 'Data masuk coy', 'data'=> $kredit]);

    }

    public function store2(Request $request)
{

    $kredit = KreditModel::create([
        'nama' => $request->nama,
        'jumlah_pinjaman' => $request->jumlah_pinjaman,
        'tenor' => $request->tenor,
        'bunga' => $request->bunga,
        'bunga_floating' => $request->bunga_floating,
        'angsuran_perbulan' => 0,
        'angsuran_total' => 0
    ]);


    $kredit->save();

    $angsuranPerBulanArray = [];


    $total_bunga_tambahan = 0;
    for ($i = 1; $i <= $kredit->tenor; $i++) {
        $total_bunga_tambahan += $request->bunga_floating * $i;


        $total_bunga = $kredit->bunga + $total_bunga_tambahan;
        $angsuranPerBulan = ($kredit->jumlah_pinjaman * ($total_bunga / 100)) + ($kredit->jumlah_pinjaman / $kredit->tenor);


        $angsuranPerBulanArray[] = $angsuranPerBulan;
    }


    $kredit->angsuran_perbulan = $angsuranPerBulanArray;


    $angsuranTotal = array_sum($angsuranPerBulanArray);
    $kredit->angsuran_total = $angsuranTotal;


    $kredit->save();

    return response()->json(['message' => 'Data masuk coy', 'data'=> $kredit]);
}


    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
{

    $kredit = KreditModel::findOrFail($id);


    $angsuranPerBulan = ($kredit->jumlah_pinjaman * ($kredit->bunga / 100)) + ($kredit->jumlah_pinjaman / $kredit->tenor);


    $angsuranTotal = $angsuranPerBulan * $kredit->tenor;


    $kredit->angsuran_perbulan = $angsuranPerBulan;
    $kredit->angsuran_total = $angsuranTotal;

    //$id = $kredit->id;

    //return view('show_kredit')
        //->with('kredit', $kredit);
        return response()->json(['message' => 'Succes liat data', 'data'=> $kredit]);
}


    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    // Di KreditController.php

public function update(Request $request, $id)
{
    $request->validate([
        'tenor' => 'required|integer|min:1', // Validasi input tenor
        'bunga' => 'required|numeric|min:0', // Validasi input bunga
    ]);

    $kredit = KreditModel::findOrFail($id);

    // Simpan bunga dan tenor yang diubah oleh pengguna
    $kredit->tenor = $request->tenor;
    $kredit->bunga = $request->bunga;

    // Hitung ulang angsuran per bulan
    $angsuranPerBulan = ($kredit->jumlah_pinjaman * ($kredit->bunga / 100)) + ($kredit->jumlah_pinjaman / $kredit->tenor);
    $kredit->angsuran_perbulan = $angsuranPerBulan;

    // Hitung ulang total angsuran
    $angsuranTotal = $angsuranPerBulan * $kredit->tenor;
    $kredit->angsuran_total = $angsuranTotal;

    $kredit->save();

    return response()->json(['message' => 'Kredit updated successfully', 'data'=>$kredit]);
}


    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {

        $kredit = KreditModel::find($id);
        $kredit->delete();

        return response()->json(['message' => 'Kredit deleted successfully', 'data'=>$kredit]);
    }
}
