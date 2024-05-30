import 'dart:convert';

UrlShortnerResponse urlShortnerResponseFromJson(String str) =>
    UrlShortnerResponse.fromJson(json.decode(str));

String urlShortnerResponseToJson(UrlShortnerResponse data) =>
    json.encode(data.toJson());

class UrlShortnerResponse {
  UrlShortnerResponse({
    required this.resultUrl, // Tandai 'resultUrl' sebagai required
  });

  String resultUrl; // Tandai bahwa 'resultUrl' tidak boleh null

  factory UrlShortnerResponse.fromJson(Map<String, dynamic> json) =>
      UrlShortnerResponse(
        resultUrl: json["result_url"] ??
            "", // Berikan nilai default jika 'resultUrl' null
      );

  Map<String, dynamic> toJson() => {
        "result_url": resultUrl,
      };
}
