// ignore_for_file: file_names

import 'package:stoop/domain/entities/login_credentials.dart';

abstract class AuthRepository {
  Future<bool> login(LoginCredentials credentials);
}