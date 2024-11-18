import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoop/routes/pages.dart';

// credentials
import 'package:stoop/domain/entities/reset_password_credentials.dart';

// usecases
import 'package:stoop/domain/usecases/reset_password-usecase.dart';

// components
import 'package:stoop/widgets/custom_input_field.dart';

// style
import 'package:stoop/widgets/style.dart';

class ResetPasswordPage extends StatefulWidget {
  final ResetPasswordUseCase resetPasswordUseCase;

  const ResetPasswordPage({super.key, required this.resetPasswordUseCase});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainGrey,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: const [
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please enter your new pasword',
                    style: TextStyle(color: AppTheme.whiteColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomInputField(
                            label: 'Password',
                            isPassword: true,
                            controller: _passwordController,
                            validator: (value) =>
                              value!.isEmpty ? 'Please enter your password':  null
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: _handleResetPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.mainGrey,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'LOG IN',
                              style: TextStyle(color: AppTheme.whiteColor),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Do you remember your password!"),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.LOGIN);
                                },
                                child: const Text(
                                  'LOG IN',
                                  style: TextStyle(color: AppTheme.mainGrey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleResetPassword() async {
    Get.toNamed(Routes.LOGIN);
    // if (_formKey.currentState?.validate() ?? false) {
    //   final credentials = ResetPasswordCredentials(
    //     password: _passwordController.text,
    //   );

    //   try {
    //     final success = await widget.resetPasswordUseCase.execute(credentials);
    //     if (success && mounted) {
    //       Get.toNamed(Routes.LOGIN);
    //     }
    //   } catch (e) {
    //     if (mounted) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Failed: ${e.toString()}')),
    //       );
    //     }
    //   }
    // }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
