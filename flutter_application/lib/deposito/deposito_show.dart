import 'package:flutter/material.dart';
import 'package:flutter_application/deposito/deposito_history.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ShowDeposito extends StatelessWidget {
  final int depositoId;
  const ShowDeposito({Key? key, required this.depositoId}) : super(key: key);

  Future<Map<String, dynamic>> getDepositoDetail() async {
    final String url = 'http://10.0.2.2:8000/api/deposito-show/$depositoId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load deposito details');
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
              MaterialPageRoute(builder: (context) => HistoryDeposito()),
            );
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getDepositoDetail(),
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
            final depoData = snapshot.data!['depo'];
            num deposito = num.tryParse(depoData['deposito'].toString()) ?? 0;
            num bunga_sebelum =
                num.tryParse(depoData['bunga_sebelum'].toString()) ?? 0;
            num bunga_sesudah =
                num.tryParse(depoData['bunga_sesudah'].toString()) ?? 0;
            num deposito_akhir =
                num.tryParse(depoData['deposito_akhir'].toString()) ?? 0;

            return Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Nama', depoData['nama']),
                  SizedBox(height: 16.0),
                  _buildDetailRow('Deposito', formatCurrency(deposito)),
                  SizedBox(height: 16.0),
                  _buildDetailRow(
                      'Pajak Bank', '${depoData['bunga_deposito']}%'),
                  SizedBox(height: 16.0),
                  _buildDetailRow('Pajak Bank', '${depoData['pajak_bank']}%'),
                  SizedBox(height: 16.0),
                  _buildDetailRow(
                      'Bunga Sebelum Pajak', formatCurrency(bunga_sebelum)),
                  SizedBox(height: 16.0),
                  _buildDetailRow(
                      'Pajak Deposito', formatCurrency(bunga_sesudah)),
                  SizedBox(height: 16.0),
                  _buildDetailRow(
                      'Deposito Akhir', formatCurrency(deposito_akhir)),
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
