import 'package:flutter/material.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:flutter_application/kredit/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HistoryTabungan extends StatefulWidget {
  const HistoryTabungan({Key? key}) : super(key: key);

  @override
  _HistoryTabunganState createState() => _HistoryTabunganState();
}

class _HistoryTabunganState extends State<HistoryTabungan> {
  int _selectedIndex = 0;
  final String url = 'http://10.0.2.2:8000/api/tabungan';

  Future getHistory() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future deleteTabungan(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String apiUrl = 'http://10.0.2.2:8000/api/tabungan/delete/$id';

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
          'History Tabungan',
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
              itemCount: snapshot.data['tabungan'].length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade300,
                thickness: 1.0,
              ),
              itemBuilder: (context, index) {
                num penghasilan = num.tryParse(snapshot.data['tabungan'][index]
                            ['penghasilan']
                        .toString()) ??
                    0;
                num pengeluaran = num.tryParse(snapshot.data['tabungan'][index]
                            ['pengeluaran']
                        .toString()) ??
                    0;
                num target = num.tryParse(snapshot.data['tabungan'][index]
                            ['target']
                        .toString()) ??
                    0;
                int timeTarget =
                    snapshot.data['tabungan'][index]['time_target'];

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
                              snapshot.data['tabungan'][index]['nama'],
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
                                      title: Text('Delete Tabungan'),
                                      content: Text(
                                          'Are you sure you want to delete this tabungan?'),
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
                                            deleteTabungan(snapshot
                                                .data['tabungan'][index]['id']);
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
                          'Target: ${formatCurrency(target)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Penghasilan: ${formatCurrency(penghasilan)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Pengeluaran: ${formatCurrency(pengeluaran)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Tanggal Mulai: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(snapshot.data['tabungan'][index]['created_at']))}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          timeTarget == 0
                              ? 'Tanggal Tercapai : Tidak bisa meraih target'
                              : 'Tanggal Tercapai: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(snapshot.data['tabungan'][index]['time']))}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Waktu(bulan): ${timeTarget == 0 ? 'Tidak bisa meraih target' : snapshot.data['tabungan'][index]['time_target']}',
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
