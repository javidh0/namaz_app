import 'package:flutter/material.dart';
import 'package:namaz_app/apis/api.dart';
import 'package:namaz_app/utils/utils.dart';

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30); // Start from bottom-left
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point
      size.width, size.height - 30, // End point
    );
    path.lineTo(size.width, 0); // Move to top-right
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String inputField = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            floating: false,
            expandedHeight: 300,
            collapsedHeight: 65,
            stretch: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ClipPath(
                  clipper: (constraints.biggest.height >= 80)
                      ? CurvedBottomClipper()
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: getColorGradient(Vaqth.magrib),
                      ),
                    ),
                    child: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.zero,
                      centerTitle: true,
                      collapseMode: CollapseMode.pin,
                      title: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Magrib",
                                style: kFont.copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (constraints.biggest.height >= 100)
                                Text(
                                  getTime(Vaqth.magrib),
                                  style: kFont.copyWith(fontSize: 12),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverList.list(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration().copyWith(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onChanged: (val) {
                    setState(() {
                      inputField = val;
                    });
                  },
                ),
              ),
            ],
          ),
          const ForPaddingWidgets(),
        ],
      ),
    );
  }
}

class ForPaddingWidgets extends StatelessWidget {
  const ForPaddingWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: Text('List Item $index'),
          );
        },
      ),
    );
  }
}
