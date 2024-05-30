<!DOCTYPE html>
<html>
<head>
    <title>Formulir Simulasi Kredit</title>
</head>
<body>
    <h1>Formulir Simulasi Kredit</h1>
    @if(session('success'))
        <div>{{ session('success') }}</div>
    @endif
    <form method="post" action="{{ route('simulasi-kredit.store') }}">
        @csrf
        <label for="nama">Nama:</label><br>
        <input type="text" id="nama" name="nama"><br>

        <label for="jumlah_pinjaman">Jumlah Pinjaman:</label><br>
        <input type="number" id="jumlah_pinjaman" name="jumlah_pinjaman"><br>

        <label for="tenor">Tenor (bulan):</label><br>
        <input type="number" id="tenor" name="tenor"><br>

        <label for="bunga">Bunga (%):</label><br>
        <input type="number" id="bunga" name="bunga"><br><br>

        <input type="submit" value="Submit">
    </form>
</body>
</html>
