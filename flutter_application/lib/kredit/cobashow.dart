import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ShowKredit extends StatelessWidget {
  final int kreditId;
  const ShowKredit({Key? key, required this.kreditId}) : super(key: key);

  Future<Map<String, dynamic>> getKreditDetail() async {
    final String url = 'http://10.0.2.2:8000/api/simulasi-kredit/$kreditId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load kredit details');
    }
  }

  String formatCurrency(num amount) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kredit Detail',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getKreditDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final kreditData = snapshot.data!['data'];
            num jumlahPinjaman =
                num.tryParse(kreditData['jumlah_pinjaman'].toString()) ?? 0;
            num angsuranPerbulan =
                num.tryParse(kreditData['angsuran_perbulan'].toString()) ?? 0;
            num angsuranTotal =
                num.tryParse(kreditData['angsuran_total'].toString()) ?? 0;

            return Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Nama', kreditData['nama']),
                  SizedBox(height: 16.0),
                  _buildDetailRow(
                      'Jumlah Pinjaman', formatCurrency(jumlahPinjaman)),
                  SizedBox(height: 16.0),
                  _buildDetailRow('Tenor', '${kreditData['tenor']} Bulan'),
                  SizedBox(height: 16.0),
                  _buildDetailRow('Bunga', '${kreditData['bunga']}%'),
                  SizedBox(height: 16.0),
                  _buildDetailRow(
                      'Angsuran Perbulan', formatCurrency(angsuranPerbulan)),
                  SizedBox(height: 16.0),
                  _buildDetailRow(
                      'Angsuran Total', formatCurrency(angsuranTotal)),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "No data available",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey.shade600,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey.shade700,
          ),
        ),
        Divider(color: Colors.grey.shade300), // Tambahkan garis pemisah
      ],
    );
  }
}
