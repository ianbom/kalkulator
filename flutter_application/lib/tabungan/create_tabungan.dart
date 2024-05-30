import 'package:flutter/material.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:flutter_application/kredit/show_kredit.dart';
import 'package:flutter_application/tabungan/show_tabungan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateTabungan extends StatefulWidget {
  @override
  _CreateTabunganState createState() => _CreateTabunganState();
}

class _CreateTabunganState extends State<CreateTabungan> {
  int _selectedIndex = 1;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController penghasilan = TextEditingController();
  final TextEditingController pengeluaran = TextEditingController();
  final TextEditingController target = TextEditingController();
  final String apiUrl = 'http://10.0.2.2:8000/api/tabungan';

  Future<void> _createTabungan(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'nama': namaController.text,
          'penghasilan': penghasilan.text,
          'pengeluaran': pengeluaran.text,
          'target': target.text,
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['tabungan']['id'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowTabungan(tabunganId: responseData),
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
          "Simulasi Menabung",
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
                controller: target,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Target",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: penghasilan,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Penghasilan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: pengeluaran,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Pengeluaran",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _createTabungan(context),
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
