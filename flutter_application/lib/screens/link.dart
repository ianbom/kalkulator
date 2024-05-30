import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/gaguna/models/url_shortner_response_model.dart';

class UrlShortenerState extends ChangeNotifier {
  final urlController = TextEditingController();

  String shortUrlMessage = "Give some long URL to convert";

  void handleGetLinkButton() async {
    final longUrl = urlController.text;

    final String shortUrl = await getShortLink(longUrl);

    shortUrlMessage = "$shortUrl";

    notifyListeners();
  }

  Future<String> getShortLink(String longUrl) async {
    final result = await http.post(
      Uri.parse('https://cleanuri.com/api/v1/shorten'),
      body: {'url': longUrl},
    );

    if (result.statusCode == 200) {
      final response = urlShortnerResponseFromJson(result.body);
      return response.resultUrl;
    } else {
      print("Error in API");
      print(result.body);
      return "There is some issue in shortening the URL";
    }
  }
}

class UrlShortenerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UrlShortenerState>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('URL Shortener'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color.fromARGB(255, 174, 209, 238),
                Colors.white,
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2196F3),
              Color(0xFF00BCD4),
            ],
            stops: [0.3, 0.9],
            tileMode: TileMode.clamp,
          ),
        ),
        padding: const EdgeInsets.all(32),
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Text(
              "URL Shortener",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Shorten your long URL quickly",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            TextField(
              controller: state.urlController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Paste the Link",
                hintStyle: TextStyle(
                  color: Colors.grey.shade700,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              child: Text(
                state.shortUrlMessage,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Clipboard.setData(ClipboardData(text: state.shortUrlMessage))
                    .whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Link is copied")),
                            ));
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                state.handleGetLinkButton();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "GET LINK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UrlShortenerState(),
      child: MaterialApp(
        title: 'URL Shortener App',
        home: UrlShortenerScreen(),
      ),
    ),
  );
}
