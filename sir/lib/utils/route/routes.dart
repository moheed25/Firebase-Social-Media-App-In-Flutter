import 'package:flutter/material.dart';
import 'package:sir/utils/route/route_name.dart';
import 'package:sir/view/dashboard/dashboardscreen.dart';
import 'package:sir/view/forgot_password/forgot_password.dart';
import 'package:sir/view/login/login_screen.dart';
import 'package:sir/view/signup/signup_screen.dart';
import 'package:sir/view/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginview:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.signupview:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case RouteName.dashboardscreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RouteName.forgotScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
