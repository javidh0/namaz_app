import 'package:flutter/material.dart';
import 'package:namaz_app/apis/api.dart';
import 'package:namaz_app/utils/utils.dart';

class MasjidScreen extends StatelessWidget {
  const MasjidScreen({super.key, required this.name, required this.color_});

  final String name;
  final List<Color> color_;

  @override
  Widget build(BuildContext context) {
    final List<Map> timings = getTimmings("masjidId");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: kFont,
        ),
        backgroundColor: color_[1],
      ),
      body: ListView.builder(
        itemCount: timings.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5.0,
                      offset: const Offset(0.0, 3.0),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      timings[index]['Name'],
                      style: kFont.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Adhan : ${timings[index]['Adhan']}\nIqamat : ${timings[index]['Iqamat']}",
                          style: kFont.copyWith(fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
