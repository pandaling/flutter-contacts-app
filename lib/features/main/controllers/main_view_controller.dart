import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/main/models/navBar_model.dart';

class MainViewConroller {
  final List<NavBarModel> _menu;

  MainViewConroller(this._menu);

  PageController? pageController;

  List<Widget> getPages() {
    List<Widget> pages = _menu.map((m) => m.page).toList();
    return pages;
  }
}
