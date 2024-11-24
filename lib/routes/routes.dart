// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stoop/pages/onboarding/welcomePage.dart';
import 'package:stoop/pages/registration/UploadScreen.dart';
import 'package:stoop/pages/registration/login.dart';
import 'package:stoop/pages/registration/signup.dart';
import 'package:stoop/pages/registration/verify_email.dart';
import 'package:stoop/pages/registration/verify_number.dart';

import '../di/injection_container.dart';
import '../domain/usecases/forget_password-usecase.dart';
import '../domain/usecases/login-usecase.dart';
import '../domain/usecases/reset_password-usecase.dart';
import '../pages/registration/forget_password.dart';
import '../pages/registration/reset_password.dart';

class AppRouter {
  static const String initial = '/';
  static const String signup = '/signup';
  static const String upload = '/upload';
  static const String verification_email = '/verification_email';
  static const String verification_number = '/verification_number';
  static const String login = '/login';
  static const String forget_password = '/forget_password';
  static const String reset_password = '/reset_password';
  static const String home = '/home';
  
  static const String location = '/location';
  static const String trips = '/trips';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case upload:
        return MaterialPageRoute(builder: (_) => const UploadScreen());
      case verification_email:
        return MaterialPageRoute(builder: (_) => const VerifyEmail());
      case verification_number:
        return MaterialPageRoute(builder: (_) => const VerifyNumber());
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage(loginUseCase: sl<LoginUseCase>()));
      case forget_password:
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage(forgetPasswordUseCase: sl<ForgetPasswordUseCase>()));
      case reset_password:
        return MaterialPageRoute(builder: (_) => ResetPasswordPage(resetPasswordUseCase: sl<ResetPasswordUseCase>()));
      // case location:
      //   return MaterialPageRoute(builder: (_) => const LocationPage());
      // case trips:
      //   return MaterialPageRoute(builder: (_) => const TripsPage());
      default:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
    }
  }
}