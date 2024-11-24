import 'package:flutter/material.dart';
import 'package:get/get.dart';

// usecase
import 'package:stoop/domain/usecases/forget_password-usecase.dart';

// components
import 'package:stoop/widgets/custom_input_field.dart';

// style
import 'package:stoop/widgets/style.dart';

import '../../routes/routes.dart';

class ForgetPasswordPage extends StatefulWidget {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  const ForgetPasswordPage({super.key, required this.forgetPasswordUseCase});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

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
                    'Forget Password!!',
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please enter your phone number to reset your password',
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
                              label: 'Phone',
                              initialValue: '+213555555555',
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your phone number'
                                  : null),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: _handleForgetPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.mainGrey,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'SEND CODE',
                              style: TextStyle(color: AppTheme.whiteColor),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed(AppRouter.login);
                              },
                              child: const Text(
                                'Do you remember your password!',
                                style: TextStyle(color: AppTheme.mainGrey),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(AppRouter.signup);
                                },
                                child: const Text(
                                  'SIGN UP',
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

  Future<void> _handleForgetPassword() async {
    Get.toNamed(AppRouter.reset_password);
    // if (_formKey.currentState?.validate() ?? false) {
    //   final credentials = ForgetPasswordCredentials(
    //     phone: _phoneController.text,
    //   );

    //   try {
    //     final success = await widget.forgetPasswordUseCase.execute(credentials);
    //     if (success && mounted) {
    //       Get.toNamed(AppRouter.reset_password);
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
    _phoneController.dispose();
    super.dispose();
  }
}
