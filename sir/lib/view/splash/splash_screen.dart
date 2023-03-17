import 'package:flutter/material.dart';
import 'package:sir/res/fonts.dart';
import 'package:sir/viewmodel/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices services = SplashServices();

  @override
  void initState() {
    super.initState();
    services.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image(image: AssetImage('assets/images/logo.jpg')),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
              'Social Media App',
              style: TextStyle(
                  color: Colors.purple,
                  fontFamily: AppFonts.sfProDisplayBold,
                  fontSize: 40,
                  fontWeight: FontWeight.w700),
            )),
          )
        ],
      )),
    );
  }
}
