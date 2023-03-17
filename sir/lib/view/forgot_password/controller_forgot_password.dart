import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sir/utils/route/route_name.dart';
import 'package:sir/utils/utils.dart';
import 'package:sir/viewmodel/services/session_manager.dart';

class ForgotController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotpassword(BuildContext context, String email) async {
    setLoading(true);
    try {
      auth.sendPasswordResetEmail(email: email).then((value) {
//
        setLoading(false);
        //
        Navigator.pushNamed(context, RouteName.loginview);
        Utils.toastMessage('please check your email to recover your password');
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
