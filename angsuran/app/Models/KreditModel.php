<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KreditModel extends Model
{
    protected $table = 'kredit';

    protected $fillable = [
        "nama",
        "jumlah_pinjaman",
        "tenor",
        "bunga",
        "bunga_floating",
        "angsuran_perbulan", // Hapus kolom angsuran_perbulan dari sini
        "angsuran_total"
    ];

    protected $casts = [
        'angsuran_perbulan' => 'json', // Tambahkan ini untuk menentukan bahwa kolom angsuran_perbulan di-cast sebagai JSON
    ];

    use HasFactory;
}
