
import 'package:get_it/get_it.dart';
import 'package:stoop/domain/repos/auth-repo-impl.dart';
import 'package:stoop/domain/repos/auth-repo.dart';
import 'package:stoop/domain/usecases/login-usecase.dart';

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
}