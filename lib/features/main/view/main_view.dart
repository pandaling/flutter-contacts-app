import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/main/controllers/main_view_controller.dart';
import 'package:flutter_contacts_app/features/main/models/navBar_model.dart';
import 'package:flutter_contacts_app/widgets/navbar/custom_navbar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  MainViewConroller mainViewConroller = MainViewConroller(menus);
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: menus.length,
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: mainViewConroller.getPages(),
        ),
        bottomNavigationBar: CustomNavigationBar(
          menu: menus,
          selectedIndex: selectedIndex,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
