import 'package:flutter/material.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:flutter_application/kredit/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HistoryDeposito extends StatefulWidget {
  const HistoryDeposito({Key? key}) : super(key: key);

  @override
  _HistoryDepositoState createState() => _HistoryDepositoState();
}

class _HistoryDepositoState extends State<HistoryDeposito> {
  int _selectedIndex = 4;
  final String url = 'http://10.0.2.2:8000/api/deposito';

  Future getHistory() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future deleteKredit(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String apiUrl = 'http://10.0.2.2:8000/api/deposito/delete/$id';

    var response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Refresh list after successful deletion
      setState(() {});
    } else {
      throw Exception('Failed to delete deposito');
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
        automaticallyImplyLeading: false,
        title: Text(
          'History Deposito',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: getHistory(),
        builder: (context, AsyncSnapshot snapshot) {
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
            return ListView.separated(
              itemCount: snapshot.data['depo'].length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade300,
                thickness: 1.0,
              ),
              itemBuilder: (context, index) {
                num deposito = num.tryParse(
                        snapshot.data['depo'][index]['deposito'].toString()) ??
                    0;
                num bunga_sebelum = num.tryParse(snapshot.data['depo'][index]
                            ['bunga_sebelum']
                        .toString()) ??
                    0;
                num bunga_sesudah = num.tryParse(snapshot.data['depo'][index]
                            ['bunga_sesudah']
                        .toString()) ??
                    0;
                num deposito_akhir = num.tryParse(snapshot.data['depo'][index]
                            ['deposito_akhir']
                        .toString()) ??
                    0;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      // Add your onTap functionality here
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data['depo'][index]['nama'],
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade600,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete depo'),
                                      content: Text(
                                          'Are you sure you want to delete this depo?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Delete'),
                                          onPressed: () {
                                            deleteKredit(snapshot.data['depo']
                                                [index]['id']);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Deposito: ${formatCurrency(deposito)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Jangka Waktu: ${snapshot.data['depo'][index]['jangka_waktu']} bulan',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Bunga Deposito: ${snapshot.data['depo'][index]['bunga_deposito']}%',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Pajak Bank: ${snapshot.data['depo'][index]['pajak_bank']}%',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Bunga Sebelum Pajak: ${formatCurrency(bunga_sebelum)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Pajak Deposito: ${formatCurrency(bunga_sesudah)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Deposito Akhir: ${formatCurrency(deposito_akhir)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                      ],
                    ),
                  ),
                );
              },
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
