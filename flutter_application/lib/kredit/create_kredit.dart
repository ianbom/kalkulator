import 'package:flutter/material.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:flutter_application/kredit/show_kredit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddKredit extends StatefulWidget {
  @override
  _AddKreditState createState() => _AddKreditState();
}

class _AddKreditState extends State<AddKredit> {
  int _selectedIndex = 3;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController jumlahPinjamanController =
      TextEditingController();
  final TextEditingController tenorController = TextEditingController();
  final TextEditingController bungaController = TextEditingController();
  final TextEditingController bungaFloating = TextEditingController();
  final String apiUrl = 'http://10.0.2.2:8000/api/simulasi-kredit';

  Future<void> _simulasiKredit(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'nama': namaController.text,
          'jumlah_pinjaman': jumlahPinjamanController.text,
          'tenor': tenorController.text,
          'bunga': bungaController.text,
          'bunga_floating': bungaFloating.text
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data']['id'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowKredit(kreditId: responseData),
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
          "Simulasi Kredit",
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
                controller: jumlahPinjamanController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Jumlah Pinjaman",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: tenorController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Tenor (bulan)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: bungaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Bunga/bulan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: bungaFloating,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Bunga floating",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _simulasiKredit(context),
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
