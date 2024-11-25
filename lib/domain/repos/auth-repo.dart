// ignore_for_file: file_names

import 'package:stoop/domain/entities/login_credentials.dart';
import 'package:stoop/domain/entities/forget_password_credentials.dart';
import 'package:stoop/domain/entities/reset_password_credentials.dart';

abstract class AuthRepository {
  Future<bool> login(LoginCredentials credentials);
  Future<bool> forgetPassword(ForgetPasswordCredentials credentials);
  Future<bool> resetPassword(ResetPasswordCredentials credentials);
}