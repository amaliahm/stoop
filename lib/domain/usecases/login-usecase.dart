// ignore_for_file: file_names

import 'package:stoop/domain/entities/login_credentials_email.dart';
import 'package:stoop/domain/repos/auth-repo.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> execute(LoginCredentials credentials) {
    return repository.login(credentials);
  }
}