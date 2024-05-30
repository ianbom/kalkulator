<!DOCTYPE html>
<html>
<head>
    <title>Detail Simulasi Kredit</title>
</head>
<body>
    <h1>Detail Simulasi Kredit</h1>
    <p>Nama: {{ $kredit->nama }}</p>
    <p>Jumlah Pinjaman: {{ number_format($kredit->jumlah_pinjaman, 0, ',', '.') }}</p>
    <p>Tenor: {{ $kredit->tenor }}</p>
    <p>Bunga: {{ $kredit->bunga }}</p>
    <label for="angsuran">Angsuran /bulan:  Rp. {{ number_format($kredit->angsuran_perbulan, 0, ',', '.') }}</label><br>
    <label for="angsuran">Angsuran Total:  Rp. {{ number_format($kredit->angsuran_total, 0, ',', '.') }}</label><br><br>
    <p><a href="{{ route('history.index') }}">Kembali</a></p>
</body>
</html>
