
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _email;
  String? _number;
  String? _password;
  String? _verificationCode;
  bool _isLocationEnabled = false;

  String? get email => _email;
  String? get number => _number;
  bool get isLocationEnabled => _isLocationEnabled;

  void setEmail(String email) {
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