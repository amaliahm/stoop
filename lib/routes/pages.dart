// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:stoop/pages/registration/welcomePage.dart';
part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: Routes.WELCOME,
      page: () => const WelcomePage(),
    ),
    // GetPage(
    //   name: Routes.SIGNUP,
    //   page: () => const SignupPage(),
    // ),
    // GetPage(
    //   name: Routes.LOGIN,
    //   page: () => const LoginPage(),
    // ),
    // GetPage(
    //   name: Routes.HOME,
    //   page: () => NavigationHomeScreen(),
    // ),
  ];
}