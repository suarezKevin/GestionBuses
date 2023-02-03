import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobil_app_bus/src/screens/home_page.dart';
import 'package:mobil_app_bus/src/screens/tickets_page.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  PageController _pageController = PageController();
  int _selected_index = 0;
  List<Widget> _screens = [
    HomePage(),
    TicketsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: HexColor("#4169E1"),
            ),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_membership_outlined,
              color: HexColor("#4169E1"),
            ),
            label: "Tickets",
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selected_index,
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selected_index = index;
    });
  }

  void _onItemTapped(int i) {
    _pageController.jumpToPage(i);
  }
}
