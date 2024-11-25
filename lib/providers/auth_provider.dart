import 'package:flutter/material.dart';
import 'package:stoop/domain/entities/login_credentials.dart';

// usecases
import '../domain/usecases/login-usecase.dart';
import '../domain/usecases/forget_password-usecase.dart';
import '../domain/usecases/reset_password-usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;

  AuthProvider(
    this.loginUseCase,
    this.resetPasswordUseCase,
    this.forgetPasswordUseCase,
  );

  String? _email;
  String? _number;
  String? _password;
  String? _verificationCode;
  bool _isLocationEnabled = false;

  String? get email => _email;
  String? get number => _number;
  bool get isLocationEnabled => _isLocationEnabled;

  Future<void> login(String password, String number) async {
    notifyListeners();

    final result = await loginUseCase.execute(LoginCredentials(phone: number, password: password));

    if (result is LoginCredentials) {
      _number = number;
      _password = password;
    }
    notifyListeners();

    // loginUseCase.execute().listen((params) {
    //   _number = params.phone;
    //   _password = params.password;
    //   notifyListeners(); // Update the UI
    // });
  }

  Future<void> setEmail(String email) async {
    _email = email;
    notifyListeners();
  }

  void setNumber(String number) {
    _number = number;
    notifyListeners();
  }

  void setVerificationCode(String code) {
    _verificationCode = code;
    notifyListeners();
  }

  void setLocationEnabled(bool enabled) {
    _isLocationEnabled = enabled;
    notifyListeners();
  }
}
