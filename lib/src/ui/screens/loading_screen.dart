import 'package:achievr/src/constants/constants.dart';
import 'package:achievr/src/constants/strings.dart';
import 'package:achievr/src/constants/variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    isUserLoggedIn().then((value) {
      if (value) {
        Navigator.pushNamed(context, '/$goalDashboardScreen');
      } else {
        Navigator.pushNamed(context, '/$loginScreen');
      }
    });

    super.initState();
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = Constants.prefs;
    final uid = prefs.getString('uid');
    if (uid != null && uid.isNotEmpty) {
      userIdStatic = uid;
      userNameStatic = prefs.getString('name');
      userEmailStatic = prefs.getString('email');
    }
    return uid != null && uid.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
