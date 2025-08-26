import 'dart:developer';
import 'package:achievr/src/constants/strings.dart';
import 'package:achievr/src/constants/variables.dart';
import 'package:achievr/src/repos/auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthRepo authRepo = AuthRepo();
  bool _loading = false;

  get isLoading => _loading;

  set setIsLoading(bool value) {
    _loading = value;
    update();
  }

  signInWithGoogle(BuildContext context) async {
    await authRepo.signInWithGoogle().then((value) {
      log('$value');
      if (value != null) {
        userIdStatic = value.uid;
        userNameStatic = value.displayName;
        userEmailStatic = value.email;
        Navigator.pushNamedAndRemoveUntil(
            context, '/$goalDashboardScreen', (route) => false);
      }
    });
  }

  logout(BuildContext context) {
    authRepo.logout().then((value) {
      userIdStatic = null;
      userNameStatic = null;
      userEmailStatic = null;
      Navigator.pushNamedAndRemoveUntil(
          context, '/$loginScreen', (route) => false);
    });
  }

  update() {
    notifyListeners();
  }
}
