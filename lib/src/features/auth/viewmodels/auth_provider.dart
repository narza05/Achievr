import 'dart:developer';
import 'package:achievr/src/core/constants/strings.dart';
import 'package:achievr/src/features/auth/repos/auth_repo.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthRepo authRepo = AuthRepo();
  bool _loading = false;
  
  String? _userId;
  String? _userName;
  String? _userEmail;

  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  get isLoading => _loading;

  set setIsLoading(bool value) {
    _loading = value;
    update();
  }

  void setUser(String uid, String? name, String? email) {
    _userId = uid;
    _userName = name;
    _userEmail = email;
    notifyListeners();
  }

  signInWithGoogle(BuildContext context) async {
    await authRepo.signInWithGoogle().then((value) {
      log('$value');
      if (value != null) {
        setUser(value.uid, value.displayName, value.email);
        Navigator.pushNamedAndRemoveUntil(
            context, '/$goalDashboardScreen', (route) => false);
      }
    });
  }

  logout(BuildContext context) {
    authRepo.logout().then((value) {
      setUser('', null, null);
      Navigator.pushNamedAndRemoveUntil(
          context, '/$loginScreen', (route) => false);
    });
  }

  update() {
    notifyListeners();
  }
}
