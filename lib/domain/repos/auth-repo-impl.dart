// ignore_for_file: file_names

import 'package:stoop/domain/entities/login_credentials.dart';
import 'package:stoop/domain/repos/auth-repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> login(LoginCredentials credentials) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}