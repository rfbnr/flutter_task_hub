import 'package:flutter/material.dart';
import 'package:task_hub/core/constants/colors.dart';
import 'package:task_hub/presentation/home/pages/home_page.dart';
import 'package:task_hub/presentation/profile/pages/profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentPage = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
  ];

  final List<NavigationDestination> _destinations = [
    const NavigationDestination(
      icon: Icon(Icons.home_filled),
      label: "Home",
    ),
    const NavigationDestination(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: _pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        elevation: 4,
        selectedIndex: currentPage,
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}
