import 'package:flutter/material.dart';
import 'package:flutter_application/deposito/deposito_history.dart';
import 'package:flutter_application/deposito/deposito_show.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:flutter_application/kredit/show_kredit.dart';
import 'package:flutter_application/tabungan/show_tabungan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateDeposito extends StatefulWidget {
  @override
  _CreateDepositoState createState() => _CreateDepositoState();
}

class _CreateDepositoState extends State<CreateDeposito> {
  int _selectedIndex = 5;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController deposito = TextEditingController();
  final TextEditingController jangka_waktu = TextEditingController();
  final TextEditingController bunga_deposito = TextEditingController();
  final TextEditingController pajak_bank = TextEditingController();
  final String apiUrl = 'http://10.0.2.2:8000/api/deposito';

  Future<void> _CreateDeposito(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'nama': namaController.text,
          'deposito': deposito.text,
          'jangka_waktu': jangka_waktu.text,
          'bunga_deposito': bunga_deposito.text,
          'pajak_bank': pajak_bank.text,
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['depo']['id'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDeposito(
              depositoId: responseData,
            ),
          ),
        );
      } else {
        print('Gagal menyimpan data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Simulasi Deposito",
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: deposito,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Deposito",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: jangka_waktu,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Jangka Waktu (bulan)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: bunga_deposito,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Bunga Deposito",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: pajak_bank,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Pajak Bank",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _CreateDeposito(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade600),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GoogleBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
