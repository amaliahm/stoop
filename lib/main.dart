import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stoop/domain/usecases/forget_password-usecase.dart';
import 'package:stoop/domain/usecases/reset_password-usecase.dart';
import 'package:stoop/providers/auth_provider.dart';
import 'package:stoop/services/ImageServiceImp.dart';
import 'package:stoop/widgets/style.dart';
import 'di/injection_container.dart';
import 'domain/usecases/login-usecase.dart';
import 'providers/upload_provider.dart';
import 'di/injection_container.dart' as di;
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            sl<LoginUseCase>(),
            sl<ResetPasswordUseCase>(), 
            sl<ForgetPasswordUseCase>()
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UploadProvider(MLKitImageService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stoop',
      theme: ThemeData(
        primaryColor: AppTheme.whiteColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
      ),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 230),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.initial,
    );
  }
}
