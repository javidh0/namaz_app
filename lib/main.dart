import 'package:flutter/material.dart';
import 'package:namaz_app/screens/location_search/location.dart';
import 'package:namaz_app/utils/utils.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(),
          '/location_search': (context) => const SearchLocationWidget()
        },
      ),
    );
  }
}
