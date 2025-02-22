import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Color primaryColor = HexColor('#023B47');
Color secondaryColor = HexColor('#1F7879');
Color secondaryTextColor = HexColor('#658E92');

// API Url
//10.0.2.2:8000
String apiUrl = 'http://10.0.2.2:8000/api';

spancer({
  double w = 0,
  double h = 0,
}) {
  return SizedBox(
    height: h,
    width: w,
  );
}

EdgeInsets spacing({double h = 0, double v = 0}) {
  return EdgeInsets.symmetric(
    horizontal: h,
    vertical: v,
  );
}
