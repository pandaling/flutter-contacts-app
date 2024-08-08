import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/access/controllers/access_controller.dart';
import 'package:flutter_contacts_app/features/main/view/main_view.dart';
import 'package:flutter_contacts_app/styles/app_style.dart';
import 'package:flutter_contacts_app/styles/media.dart';
import 'package:flutter_contacts_app/styles/palette.dart';
import 'package:flutter_contacts_app/widgets/button/rounded_rectangle_button.dart';
import 'package:flutter_contacts_app/widgets/text_field/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _userIdCtrl = TextEditingController();
  String errMsg = '';

  void _login() async {
    if (_userIdCtrl.text.isEmpty) {
      setState(() {
        errMsg = 'Please key in user id to login';
      });

      return;
    }

    // go to login
    bool success = await AccessController.instance.login(_userIdCtrl.text);

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MainView()),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong!'),
          backgroundColor: Palette.blue,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userIdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hi There! \n',
                      style: AppStyle.buttonText,
                    ),
                    TextSpan(
                      text: 'Please login to see your contact list',
                      style: TextStyle(color: Palette.placeholder),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              CustomTextFieldWidget(
                controller: _userIdCtrl,
                tfTitle: 'User ID',
                isCompulsory: true,
                labelText: '019237sxfsdsasd',
                prefixIcon: Image.asset(Media.profileActive),
              ),
              errMsg.isNotEmpty
                  ? Text(
                      errMsg,
                      style: AppStyle.errorText,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 32.0),
              RoundedRectangleButton(
                onPressed: () => _login(),
                label: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
