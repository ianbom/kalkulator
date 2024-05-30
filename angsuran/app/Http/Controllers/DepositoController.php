<?php

namespace App\Http\Controllers;

use App\Models\DepositoModel;
use Illuminate\Http\Request;

class DepositoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $depo = DepositoModel::all();

        foreach ($depo as $d){
            $bungaSebelumPajak = $d->deposito * $d->bunga_depostio/100;
            $d->bunga_sebelum_pajak = $bungaSebelumPajak;

            $bungaSetelahPajak = $bungaSebelumPajak - ($bungaSebelumPajak * $d->pajak_bank/100);
            $d->bunga_setelah_pajak = $bungaSetelahPajak;
        }

        return response()->json(['message' => 'Succes', 'depo'=> $depo]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $depo = DepositoModel::all();

        return response()->json(['message' => 'depo Succes', 'depo'=> $depo]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $bunga_sebelum = $request->deposito * $request->bunga_deposito/100;
        $bunga_sesudah = $bunga_sebelum * $request->pajak_bank/100;
        $deposito_akhir = $request->deposito + $bunga_sebelum - $bunga_sesudah;

        $depo = DepositoModel::create([
            "nama" => $request->nama,
            "deposito" => $request->deposito,
            "jangka_waktu" => $request->jangka_waktu,
            "bunga_deposito" => $request->bunga_deposito,
            "pajak_bank" => $request->pajak_bank,
            "bunga_sebelum" => $bunga_sebelum,
            "bunga_sesudah" => $bunga_sesudah,
            "deposito_akhir" => $deposito_akhir

        ]);

        return response()->json(['message' => 'depo masuk coy', 'depo'=> $depo]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $depo = DepositoModel::findOrFail($id);

        return response()->json(['message' => 'depo terlihat coy', 'depo'=> $depo]);

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
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $depo = DepositoModel::find($id);
        $depo->delete();

        return response()->json(['message' => 'depo deleted successfully', 'depo'=>$depo]);
    }
}
