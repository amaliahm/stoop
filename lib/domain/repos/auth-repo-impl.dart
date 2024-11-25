// ignore_for_file: file_names

// credentials
import 'package:stoop/domain/entities/login_credentials_email.dart';
import 'package:stoop/domain/entities/forget_password_credentials.dart';
import 'package:stoop/domain/entities/reset_password_credentials.dart';

// repos
import 'package:stoop/domain/repos/auth-repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> login(LoginCredentials credentials) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> forgetPassword(ForgetPasswordCredentials credentials) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> resetPassword(ResetPasswordCredentials credentials) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}