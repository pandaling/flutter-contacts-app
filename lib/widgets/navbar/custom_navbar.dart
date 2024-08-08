import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.menu,
    required this.selectedIndex,
    required this.onTap,
  });

  final List menu;
  final int selectedIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    const height = kBottomNavigationBarHeight;

    return SafeArea(
      child: Material(
        elevation: 0.5,
        child: SizedBox(
          height: height,
          width: MediaQuery.of(context).size.width,
          child: TabBar(
            indicatorPadding: EdgeInsets.zero,
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w500,
            ),
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            onTap: onTap,
            tabs: menu
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    Tab(
                      icon: Image.asset(
                        key == selectedIndex ? value.imageActive : value.imageInactive,
                        width: 32.0,
                        height: 32.0,
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ),
      ),
    );
  }
}
