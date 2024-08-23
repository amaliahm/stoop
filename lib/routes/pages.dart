// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:stoop/pages/welcomePage.dart';
part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: Routes.WELCOME,
      page: () => const WelcomePage(),
    ),
  ];
}