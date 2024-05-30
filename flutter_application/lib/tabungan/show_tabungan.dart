import 'package:flutter/material.dart';
import 'package:flutter_application/tabungan/history_tabungan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ShowTabungan extends StatelessWidget {
  final int tabunganId;
  const ShowTabungan({Key? key, required this.tabunganId}) : super(key: key);

  Future<Map<String, dynamic>> getTabunganDetail() async {
    final String url = 'http://10.0.2.2:8000/api/tabungan-show/$tabunganId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load tabungan details');
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
          'Tabungan Detail',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryTabungan()),
            );
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getTabunganDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
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
            final tabunganData = snapshot.data!['tabungan'];
            num penghasilan =
                num.tryParse(tabunganData['penghasilan'].toString()) ?? 0;
            num pengeluaran =
                num.tryParse(tabunganData['pengeluaran'].toString()) ?? 0;
            num target = num.tryParse(tabunganData['target'].toString()) ?? 0;
            int timeTarget = tabunganData['time_target'];

            String tanggalTercapai = timeTarget == 0
                ? 'Tidak bisa mencapai target'
                : DateFormat('dd MMMM yyyy')
                    .format(DateTime.parse(tabunganData['time']));
            String waktuDibutuhkan =
                timeTarget == 0 ? '' : '${tabunganData['time_target']} bulan';

            return Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Nama', tabunganData['nama']),
                  SizedBox(height: 16.0),
                  _buildDetailRow('Target', formatCurrency(target)),
                  SizedBox(height: 16.0),
                  _buildDetailRow('Penghasilan', formatCurrency(penghasilan)),
                  SizedBox(height: 16.0),
                  _buildDetailRow('Pengeluaran', formatCurrency(pengeluaran)),
                  _buildDetailRow(
                      'Tanggal Dimulai',
                      DateFormat('dd MMMM yyyy')
                          .format(DateTime.parse(tabunganData['created_at']))),
                  SizedBox(height: 16.0),
                  _buildDetailRow('Tanggal Tercapai', tanggalTercapai),
                  SizedBox(height: 16.0),
                  _buildDetailRow('Waktu dibutuhkan', waktuDibutuhkan),
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
            color: Colors.blue.shade600,
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
        Divider(color: Colors.grey.shade200), // Tambahkan garis pemisah
      ],
    );
  }
}
