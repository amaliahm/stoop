// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:stoop/di/injection_container.dart';

// usecases
import 'package:stoop/domain/usecases/forget_password-usecase.dart';
import 'package:stoop/domain/usecases/reset_password-usecase.dart';
import 'package:stoop/domain/usecases/login-usecase.dart';

// screens
import 'package:stoop/pages/registration/UploadScreen.dart';
import 'package:stoop/pages/registration/forget_password.dart';
import 'package:stoop/pages/registration/reset_password.dart';
import 'package:stoop/pages/registration/login.dart';
import 'package:stoop/pages/onboarding/welcomePage.dart';
import 'package:stoop/pages/registration/signup.dart';
part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: Routes.WELCOME,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignupPage(),
    ),
    GetPage(
      name: Routes.FORGET_PASSWORD,
      page: () => ForgetPasswordPage(forgetPasswordUseCase: sl<ForgetPasswordUseCase>()),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD,
      page: () => ResetPasswordPage(resetPasswordUseCase: sl<ResetPasswordUseCase>()),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(loginUseCase: sl<LoginUseCase>()),
    ),
    GetPage(
      name: Routes.UPLOAD,
      page: () => const UploadScreen(),
    ),
  ];
}