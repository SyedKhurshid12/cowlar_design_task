import 'package:cowlar_design_task/bloc/bottom_nav_bloc/Bottom_nav_state.dart';
import 'package:cowlar_design_task/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:cowlar_design_task/bloc/bottom_nav_bloc/bottom_nav_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/colors.dart';
import '../views/more_home/more_screen.dart';
import '../views/movie_home/movie_screen.dart';
import '../views/search/search_new.dart';

class BottomNavBar extends StatefulWidget {
  final int? index;

  const BottomNavBar({super.key, this.index});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  BottomNavBarBloc bottomNavBarBloc = BottomNavBarBloc();

  @override
  void initState() {
    // TODO: implement initState
    bottomNavBarBloc.add(TabTapped(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavBarBloc>(
      create: (context) => bottomNavBarBloc,
      child: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
          builder: (context, state) {
        if (state is BottomNavBarStateLoaded) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              alignment: Alignment.bottomCenter,
              children: const [
                MovieScreen(),
                SearchNew(),
                WatchList(),
              ],
            ),
            bottomNavigationBar:
                _buildBottomNavigationBar(bottomNavBarBloc, state),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Widget _buildBottomNavigationBar(
      BottomNavBarBloc bottomNavBarBloc, BottomNavBarStateLoaded stateLoaded) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colorBlue, width: 2.0),
        ),
      ),
      child: BottomNavigationBar(
        selectedFontSize: 10,
        backgroundColor: primaryColor,
        selectedItemColor: colorBlue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: _buildNavigationBarItems(stateLoaded.currentIndex),
        currentIndex: stateLoaded.currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          bottomNavBarBloc.add(TabTapped(index));
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationBarItems(int currentIndex) {
    return [
      _buildNavigationBarItem("assets/Home.svg", "Home", 0, currentIndex),
      _buildNavigationBarItem("assets/Search.svg", "Search", 1, currentIndex),
      _buildNavigationBarItem("assets/Save.svg", "Watch list", 2, currentIndex),
    ];
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      String iconAsset, String label, int index, int currentIndex) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildSvgPicture(
          iconAsset,
          currentIndex == index ? colorBlue : Colors.grey,
        ),
      ),
      label: label,
    );
  }

  Widget _buildSvgPicture(String assetName, Color color) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      child: SvgPicture.asset(assetName),
    );
  }
}
