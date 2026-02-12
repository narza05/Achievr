import 'package:achievr/src/core/constants/my_styles.dart';
import 'package:achievr/src/features/auth/viewmodels/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/widgets/buttons/my_button_white.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButtonWhite(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/icon/google_icon.png'),
                    fit: BoxFit.cover,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Google sign in", style: MyStyles.headline3),
                ],
              ),
              function: () {
                authProvider.signInWithGoogle(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
