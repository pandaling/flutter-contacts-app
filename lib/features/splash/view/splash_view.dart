import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/access/controllers/access_controller.dart';
import 'package:flutter_contacts_app/features/access/view/login_view.dart';
import 'package:flutter_contacts_app/features/contact/controllers/contact_controller.dart';
import 'package:flutter_contacts_app/features/main/view/main_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // _loadData() async {
  //   List data = await FileLoader.from('assets/data.json');
  //   List<Contact> contacts = data.map((contact) => Contact.fromJson(contact)).toList();
  //   print(contacts);
  // }

  _validateUserStatus() async {
    await Future.delayed(const Duration(seconds: 1));

    // before doing anything, load the contact list data first
    // ContactController contactController = ContactController();
    await ContactController.instance.loadData();

    // Load login info
    // AccessController accessController = AccessController();
    await AccessController.instance.loadData();

    if (AccessController.instance.isLoggedIn) {
      await Future.delayed(const Duration(seconds: 1));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MainView()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    }
  }

  @override
  void initState() {
    // Timer(Duration(seconds: 3), () {
    //   Navigator.push(context, MaterialPageRoute(builder: (_) => const MainView()));
    // });
    super.initState();
    // _loadData();
    _validateUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: const LinearProgressIndicator(),
        ),
      ),
    );
  }
}
