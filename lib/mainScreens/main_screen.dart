import 'dart:async';

import 'package:aplicacion_conductor/tabPages/earning_tab.dart';
import 'package:aplicacion_conductor/tabPages/profile_tab.dart';
import 'package:aplicacion_conductor/tabPages/rating_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../tabPages/home_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {

  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index){
    setState(() {
      selectedIndex = index;
      tabController!.index =  selectedIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const[
            HomeTabPage(),
            EarningTabPage(),
            RatingTabPage(),
            ProfileTabPage()

          ],

          ),
          bottomNavigationBar: BottomNavigationBar(
          items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Earnings'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Rating'
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile'
          )
      ],
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(fontSize: 21),
            showUnselectedLabels: true,
            currentIndex: selectedIndex,
            onTap: onItemClicked,

    ),

    );
  }
}
