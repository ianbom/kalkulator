<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\TabunganTable;
use Illuminate\Support\Facades\DB;

class TabunganController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tabungan = TabunganTable::all();

        foreach($tabungan as $t){
            $simpananPerBulan = $t->penghasilan - $t->pengeluaran;
            $t->simpanan_bulanan = $simpananPerBulan;

            $timeTarget = ($t->target / $simpananPerBulan);
            $t->time_target = $timeTarget;

            if($timeTarget < 0){
                $timeTarget = 0;
            }


        }

        return response()->json(['message' => 'Tabungan Succes', 'tabungan'=> $tabungan]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $tabungan = TabunganTable::all();

        return response()->json(['message' => 'Tabungan Succes', 'tabungan'=> $tabungan]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $timeTarget = ceil($request->target / ($request->penghasilan - $request->pengeluaran));

        $startDate = date('Y-m-d');

        $newDate = date('Y-m-d', strtotime("+$timeTarget months", strtotime($startDate)));
        if($timeTarget < 0){
            $timeTarget = 0;
           $newDate = null;
        }
        $tabungan = TabunganTable::create([
            "nama" => $request->nama,
            "penghasilan" => $request->penghasilan,
            "pengeluaran" => $request->pengeluaran,
            "target" => $request->target,
            "time_target" => $timeTarget,
            "time" => $newDate
        ]);

        return response()->json(['message' => 'Tabungan masuk coy', 'tabungan'=> $tabungan]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $tabungan = TabunganTable::findOrFail($id);

        return response()->json(['message' => 'Tabungan terlihat coy', 'tabungan'=> $tabungan]);
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
        $tabungan = TabunganTable::find($id);
        $tabungan->delete();

        return response()->json(['message' => 'Tabungan deleted successfully', 'tabungan'=>$tabungan]);
    }


}
