
import 'package:get_it/get_it.dart';

// repos
import 'package:stoop/domain/repos/auth-repo-impl.dart';
import 'package:stoop/domain/repos/auth-repo.dart';

// usecases
import 'package:stoop/domain/usecases/login-usecase.dart';
import 'package:stoop/domain/usecases/forget_password-usecase.dart';
import 'package:stoop/domain/usecases/reset_password-usecase.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // repos
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );

  // usecases
  sl.registerLazySingleton(
    () => LoginUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => ForgetPasswordUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => ResetPasswordUseCase(sl()),
  );
}