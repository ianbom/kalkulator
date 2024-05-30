<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>History</title>
</head>
<body>
    <h1>Riwayat Kredit</h1>



    @foreach ($kredit as $k)
    <label for="nama">Nama: {{ $k->nama }}</label><br>
    <label for="jumlah_pinjaman">Jumlah Pinjaman:  Rp. {{ number_format($k->jumlah_pinjaman, 0, ',', '.') }}</label><br>
    <label for="tenor">Tenor (bulan):  {{ $k->tenor }}</label><br>
    <label for="bunga">Bunga /bulan (%):  {{ $k->bunga }}</label><br>
    <label for="angsuran">Angsuran /bulan:  Rp. {{ number_format($k->angsuran_perbulan, 0, ',', '.') }}</label><br>
    <label for="angsuran">Angsuran Total:  Rp. {{ number_format($k->angsuran_total, 0, ',', '.') }}</label><br><br>


    <br>
    @endforeach
</body>
</html>
