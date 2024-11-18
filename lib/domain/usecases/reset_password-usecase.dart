// ignore_for_file: file_names

import 'package:stoop/domain/entities/reset_password_credentials.dart';
import 'package:stoop/domain/repos/auth-repo.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<bool> execute(ResetPasswordCredentials credentials) {
    return repository.resetPassword(credentials);
  }
}