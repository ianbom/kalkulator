import 'package:flutter/material.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:flutter_application/kredit/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HistoryKredit extends StatefulWidget {
  const HistoryKredit({Key? key}) : super(key: key);

  @override
  _HistoryKreditState createState() => _HistoryKreditState();
}

class _HistoryKreditState extends State<HistoryKredit> {
  int _selectedIndex = 2;
  final String url = 'http://10.0.2.2:8000/api/history';

  Future getHistory() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future deleteKredit(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String apiUrl = 'http://10.0.2.2:8000/api/kredit/delete/$id';

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
      throw Exception('Failed to delete kredit');
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
          'History Kredit',
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
              itemCount: snapshot.data['data'].length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade300,
                thickness: 1.0,
              ),
              itemBuilder: (context, index) {
                num jumlahPinjaman = num.tryParse(snapshot.data['data'][index]
                            ['jumlah_pinjaman']
                        .toString()) ??
                    0;
                num angsuranPerbulan = num.tryParse(snapshot.data['data'][index]
                            ['angsuran_perbulan']
                        .toString()) ??
                    0;
                num angsuranTotal = num.tryParse(snapshot.data['data'][index]
                            ['angsuran_total']
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
                              snapshot.data['data'][index]['nama'],
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
                                      title: Text('Delete Kredit'),
                                      content: Text(
                                          'Are you sure you want to delete this kredit?'),
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
                                            deleteKredit(snapshot.data['data']
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
                        SizedBox(height: 10.0),
                        Text(
                          'Jumlah Pinjaman: ${formatCurrency(jumlahPinjaman)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Tenor: ${snapshot.data['data'][index]['tenor']} bulan',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Bunga: ${snapshot.data['data'][index]['bunga']} %',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Bunga floating: ${snapshot.data['data'][index]['bunga_floating']} %',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Angsuran Perbulan: ${formatCurrency(angsuranPerbulan)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Total Angsuran: ${formatCurrency(angsuranTotal)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
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
