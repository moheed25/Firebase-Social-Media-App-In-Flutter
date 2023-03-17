import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sir/firebase_options.dart';
import 'package:sir/res/colours.dart';
import 'package:sir/res/fonts.dart';
import 'package:sir/utils/route/route_name.dart';
import 'package:sir/utils/route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColors.primaryMaterialColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: AppColors.whiteColor,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontFamily: AppFonts.sfProDisplayMedium,
              color: AppColors.primaryTextTextColor,
            ),
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontSize: 48,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline2: TextStyle(
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontSize: 32,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline3: TextStyle(
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontSize: 28,
                fontWeight: FontWeight.w500,
                height: 1.9),
            headline4: TextStyle(
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline5: TextStyle(
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline6: TextStyle(
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                height: 1.6),
            bodyText1: TextStyle(
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.primaryTextTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                height: 1.6),
            bodyText2: TextStyle(
                fontFamily: AppFonts.sfProDisplayRegular,
                color: AppColors.primaryTextTextColor,
                fontSize: 14,
                height: 1.6),
            caption: TextStyle(
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.primaryTextTextColor,
                fontSize: 12,
                height: 2.26),
          )),
      // home: const LoginScreen(),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
