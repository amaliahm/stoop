// ignore_for_file: file_names

import 'package:stoop/domain/entities/forget_password_credentials.dart';
import 'package:stoop/domain/repos/auth-repo.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<bool> execute(ForgetPasswordCredentials credentials) {
    return repository.forgetPassword(credentials);
  }
}