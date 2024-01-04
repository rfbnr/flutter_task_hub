import 'package:flutter/material.dart';

import '../../../core/components/dialog_widget.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/user_model.dart';
import '../../profile/pages/profile_page.dart';
import 'home_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.user});

  final UserModel user;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late ProfilePage profilePage;
  late HomePage homePage;
  int currentPage = 0;

  final List<Widget> _pages = [];

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
  void initState() {
    super.initState();
    profilePage = ProfilePage(user: widget.user);
    homePage = HomePage(user: widget.user);

    _pages.addAll([
      homePage,
      profilePage,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: _pages[currentPage],
      floatingActionButton: currentPage == 0
          ? FloatingActionButton(
              onPressed: () => DialogWidget().showDialogWidget(context, null),
              child: const Icon(Icons.add),
            )
          : null,
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
