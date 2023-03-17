import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sir/utils/route/route_name.dart';
import 'package:sir/viewmodel/services/session_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),

        // Text(SessionController().userid.toString()),
        // Text(SessionController().ue\.toString()),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((value) {
                  SessionController().userid = '';
                  Navigator.pushNamed(context, RouteName.loginview);
                });
              },
              icon: Icon(Icons.login_outlined))
        ],
      ),
    );
  }
}
