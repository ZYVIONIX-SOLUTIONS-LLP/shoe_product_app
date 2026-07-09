import 'package:flutter/material.dart';
import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _pageIndex = 0;

  final List<Widget> _screens = [
    const Center(
      child: Text(
        'Home Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    const Center(
      child: Text(
        'Search Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    const Center(
      child: Text(
        'Favorites Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Curved Navigation Pro'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_pageIndex],
      ),
      bottomNavigationBar: CurvedNavigationBarPro(
        currentIndex: _pageIndex,
        items: const [
          CurvedNavigationItemPro(
            inactiveIcon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'Home',
          ),
          CurvedNavigationItemPro(
            inactiveIcon: Icons.search_outlined,
            activeIcon: Icons.search_rounded,
            label: 'Search',
          ),
          CurvedNavigationItemPro(
            inactiveIcon: Icons.favorite_outline,
            activeIcon: Icons.favorite_rounded,
            label: 'Favorites',
            badgeText: '3',
          ),
          CurvedNavigationItemPro(
            inactiveIcon: Icons.person_outline,
            activeIcon: Icons.person_rounded,
            label: 'Profile',
          ),
        ],
        navbarStyle: CNBPStyles.classicIndigo,
        activeColor: Colors.amber[700]!,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
