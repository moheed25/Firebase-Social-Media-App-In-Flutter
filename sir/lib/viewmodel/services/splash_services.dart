import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sir/utils/route/route_name.dart';
import 'package:sir/viewmodel/services/session_manager.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    if (user != null) {
      SessionController().userid = user.uid.toString();
      Timer(Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.dashboardscreen));
    } else {
      Timer(Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.loginview));
    }
  }
}
