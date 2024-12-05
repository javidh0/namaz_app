import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namaz_app/apis/api.dart';

TextStyle kFont = GoogleFonts.poppins();

enum Vaqth { magrib }

class LocationProvider extends ChangeNotifier {
  String locationId = "#1010";
  final LocationData _locationData = LocationData();

  void modifyLocation(String locationId) {
    this.locationId = locationId;
    notifyListeners();
  }

  String getLocationId() {
    return locationId;
  }

  String getLocationName() {
    return _locationData.getLocationName(locationId);
  }
}
