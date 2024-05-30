<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DepositoModel extends Model
{
    protected $table = 'deposito_table';

    protected $fillable = [
        "nama",
        "deposito",
        "jangka_waktu",
        "bunga_deposito",
        "pajak_bank",
        "bunga_sebelum",
        "bunga_sesudah",
        "deposito_akhir"
    ];

    use HasFactory;
}
