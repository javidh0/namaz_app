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
  final ScrollController _controller = ScrollController();
  final ScrollController _listViewController = ScrollController();
  bool isCollapsed = false;
  List<Map> masjids = getMasjids();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
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
                if (constraints.biggest.height <= 100 && !isCollapsed) {
                  isCollapsed = true;
                } else if (constraints.biggest.height >= 250 && isCollapsed) {
                  isCollapsed = false;
                }
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
                padding: const EdgeInsets.all(15),
                child: TextField(
                  style: kFont,
                  onTap: () {
                    _controller.animateTo(225,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.bounceInOut);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder().copyWith(
                      borderSide: BorderSide(
                          color: getColorGradient(Vaqth.magrib)[1], width: 2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    border: const OutlineInputBorder()
                        .copyWith(borderRadius: BorderRadius.circular(50)),
                    hintText: 'Search your Masjid',
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  controller: _listViewController,
                  itemCount: masjids.length,
                  itemBuilder: (context, index) {
                    _listViewController.addListener(() {
                      _controller.animateTo(
                        225,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.decelerate,
                      );
                    });
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                        height: 100,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                masjids[index]['Name'],
                                style: kFont.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Adhan : ${masjids[index]['Adhan']}",
                                    style: kFont.copyWith(fontSize: 15),
                                  ),
                                  Text(
                                    "   ",
                                    style: kFont.copyWith(fontSize: 15),
                                  ),
                                  Text(
                                    "Iqamat : ${masjids[index]['Iqamat']}",
                                    style: kFont.copyWith(fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const AddWhiteScrollPadding(),
            ],
          ),
        ],
      ),
    );
  }
}

class AddWhiteScrollPadding extends StatelessWidget {
  const AddWhiteScrollPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      height: MediaQuery.of(context).size.height - kToolbarHeight,
    );
  }
}
