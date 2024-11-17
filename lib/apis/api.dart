import 'dart:ui';

import 'package:namaz_app/utils/utils.dart';

List<Color> getColorGradient(Vaqth x) {
  return const [
    Color(0xFF1e3c72),
    Color.fromRGBO(55, 115, 219, 1),
  ];
}

String getTime(Vaqth x) {
  return "00:00 - 00:00";
}

List<Map> getMasjids() {
  List<Map> tr = [];
  for (int i = 0; i < 50; i++) {
    Map temp = {
      "Name": 'Masjid - $i',
      "Adhan": "00:00",
      "Iqamat": "00:00",
    };
    tr.add(temp);
  }
  return tr;
}
