import 'package:flutter/material.dart';
import 'package:namaz_app/apis/api.dart';
import 'package:namaz_app/utils/utils.dart';
import 'package:provider/provider.dart';

class SearchLocationWidget extends StatefulWidget {
  const SearchLocationWidget({super.key});

  @override
  State<SearchLocationWidget> createState() => _SearchLocationWidgetState();
}

class _SearchLocationWidgetState extends State<SearchLocationWidget> {
  final LocationData _locationData = LocationData();
  List<Map> location_ = [];
  @override
  void initState() {
    location_ = _locationData.getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
        child: Column(
          children: [
            TextField(
              onChanged: (key) {
                setState(() {
                  location_ = _locationData.getLocation(key: key);
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 25,
                  ),
                ),
                border: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(
              height: kToolbarHeight / 2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 2 * kToolbarHeight,
              child: ListView.builder(
                itemCount: location_.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        context
                            .read<LocationProvider>()
                            .modifyLocation(location_[index]["Id"]);
                        Navigator.pop(context);
                      },
                      child: Text(location_[index]['Name']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
