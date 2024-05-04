
import 'package:cowlar_design_task/views/more_home/more_screen.dart';
import 'package:cowlar_design_task/views/movie_home/movie_screen.dart';
import 'package:cowlar_design_task/views/search/search_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/colors.dart';

class BottomNavBar extends StatefulWidget {
  int? index;

  BottomNavBar({Key? key, this.index}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: IndexedStack(
        index: currentIndex,
        alignment: Alignment.bottomCenter,
        children: const [
          MovieScreen(),
          SearchNew(),
          WatchList(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: colorBlue, width: 2.0), // Set border color and width
          ),
        ),
        child: BottomNavigationBar(
          selectedFontSize: 10,
          backgroundColor: primaryColor,
          selectedItemColor: colorBlue,
          // Change the color of selected items
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildSvgPicture("assets/Home.svg",
                    currentIndex == 0 ? colorBlue : Colors.grey),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildSvgPicture("assets/Search.svg",
                    currentIndex == 1 ? colorBlue : Colors.grey),
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildSvgPicture("assets/Save.svg",
                    currentIndex == 2 ? colorBlue : Colors.grey),
              ),
              label: "Watch list",
            ),
          ],
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSvgPicture(String assetName, Color color) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      child: SvgPicture.asset(assetName),
    );
  }
}
