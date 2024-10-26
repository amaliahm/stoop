import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoop/domain/entities/login_credentials.dart';
import 'package:stoop/domain/usecases/login-usecase.dart';
import 'package:stoop/routes/pages.dart';
import 'package:stoop/widgets/custom_input_field.dart';
import 'package:stoop/widgets/style.dart';

class LoginPage extends StatefulWidget {
  final LoginUseCase loginUseCase;

  const LoginPage({super.key, required this.loginUseCase});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
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
                    'Log In',
                    style: TextStyle(
                      color: AppTheme.whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Welcome Back!!',
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
                            validator: (value) =>
                              value!.isEmpty ? 'Please enter your phone number':  null
                          ),
                          const SizedBox(height: 16),
                          CustomInputField(
                            label: 'Password',
                            isPassword: true,
                            controller: _passwordController,
                            validator: (value) =>
                              value!.isEmpty ? 'Please enter your password':  null
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // forget password
                              },
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(color: AppTheme.mainGrey),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: _handleLogin,
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.SIGNUP);
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

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final credentials = LoginCredentials(
        phone: _phoneController.text,
        password: _passwordController.text,
      );

      try {
        final success = await widget.loginUseCase.execute(credentials);
        if (success && mounted) {
          // home screen
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
