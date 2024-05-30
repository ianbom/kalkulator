<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TabunganTable extends Model
{
    protected $table = 'tabungan';

    protected $fillable = [
        "nama",
        "penghasilan",
        "pengeluaran",
        "target",
        "time_target",
        "time",
    ];
    use HasFactory;
}
