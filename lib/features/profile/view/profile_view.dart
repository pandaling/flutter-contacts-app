import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/access/controllers/access_controller.dart';
import 'package:flutter_contacts_app/features/contact/models/contact_model.dart';
import 'package:flutter_contacts_app/features/splash/view/splash_view.dart';
import 'package:flutter_contacts_app/styles/app_style.dart';
import 'package:flutter_contacts_app/widgets/avatar/custom_circle_avatar.dart';
import 'package:flutter_contacts_app/widgets/button/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  _update() {}

  @override
  Widget build(BuildContext context) {
    Contact? contact = context.watch<AccessController>().loginUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: AppStyle.appBarText,
        ),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              AccessController.instance.logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SplashView()),
              );
            },
            child: const Text(
              'Logout',
              style: AppStyle.buttonText,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            Align(
              alignment: Alignment.center,
              child: CustomCircleAvatar(contact: contact),
            ),
            const SizedBox(height: 12.0),
            Text(
              '${contact?.firstName} ${contact?.lastName}',
              style: AppStyle.textFieldLabel,
            ),
            const SizedBox(height: 12.0),
            Text(
              '${contact?.email}',
              style: AppStyle.textFieldLabel,
            ),
            const SizedBox(height: 12.0),
            Text(
              '${contact?.dob}',
              style: AppStyle.textFieldLabel,
            ),
            const SizedBox(height: 12.0),
            RoundedRectangleButton(
              onPressed: () => _update(),
              label: 'Update my detail',
            ),
          ],
        ),
      ),
    );
  }
}
