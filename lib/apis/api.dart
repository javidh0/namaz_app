import 'dart:ui';

import 'package:namaz_app/utils/utils.dart';

List<Color> getColorGradient(Vaqth x) {
  return const [
    Color(0xFF1e3c72),
    Color.fromRGBO(55, 115, 219, 1),
  ];
}

List<Map> getTimmings(String masjidId) {
  List<Map> tr = [];
  List<String> temp = ["Fajir", "Duhar", "Asar", "Magrib", "Isha"];
  for (var element in temp) {
    tr.add({
      "Name": element,
      "Adhan": "00:00",
      "Iqamat": "00:00",
    });
  }
  return tr;
}

class LocationData {
  final List<Map> _location = [];
  LocationData() {
    Map temp = {"Name": "Tindivanam", "Id": "#1010"};
    _location.add(temp);

    for (int i = 1; i < 20; i++) {
      Map temp = {"Name": "Location $i", "Id": "#${1010 + i}"};
      _location.add(temp);
    }
  }

  String getLocationName(String id) {
    for (var elem in _location) {
      if (elem['Id'] == id) return elem["Name"];
    }
    return "Not Found";
  }

  List<Map> getLocation({String key = ""}) {
    List<Map> tr = [];
    if (key == "") return _location;

    for (var elements in _location) {
      if (elements["Name"].contains(key)) tr.add(elements);
    }
    return tr;
  }
}

String getTime(Vaqth x) {
  return "00:00 - 00:00";
}

List<Map> getMasjids({String key = ""}) {
  List<Map> tr = [];
  for (int i = 1; i <= 10; i++) {
    Map temp = {
      "Name": 'Masjid - $i',
      "Adhan": "01:00",
      "Iqamat": "01:10",
      "Id": "#${2010 + i}"
    };
    tr.add(temp);
  }
  if (key != "") return masjisdFilter(key, tr);
  return tr;
}

List<Map> masjisdFilter(String key, List<Map> masjid) {
  List<Map> tr = [];
  for (var element in masjid) {
    if (element["Name"].contains(key)) tr.add(element);
  }
  return tr;
}
