import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sir/utils/route/route_name.dart';
import 'package:sir/utils/utils.dart';
import 'package:sir/viewmodel/services/session_manager.dart';

class SignupController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signup(
      BuildContext context, String username, String email, String password) {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        //
        SessionController().userid = value.user!.uid.toString();

        //
//
        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'onlineStatus': 'onOne',
          'phone': '',
          'userName': username,
          'profile': '',
        }).then((value) {
          setLoading(false);
          //
          Navigator.pushNamed(context, RouteName.dashboardscreen);
          //
        }).onError((error, stackTrace) {
          setLoading(false);

          Utils.toastMessage(error.toString());
        });

        // Utils.toastMessage("User Created Successfully ");
        // setLoading(false);
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
