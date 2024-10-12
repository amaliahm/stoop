// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:stoop/widgets/style.dart';
import '../../widgets/auth_progress_bar.dart';
import '../../widgets/custom_input_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _passwordController;
  late TextEditingController _rePasswordController;

   @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.mainGrey, AppTheme.whiteColor, AppTheme.whiteColor],
            stops: [0.15, 0.15, 0.5],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppTheme.whiteColor),
                      onPressed: () {
                      },
                    ),
                    const SizedBox(height: 30),
                    const ProgressBar(currentStep: 1, totalSteps: 2),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomInputField(
                            label: 'NAME',
                            initialValue: 'Amina GHANDOUZ',
                            validator: (value) => value!.isEmpty ? 'Name is required' : null,
                          ),
                          CustomInputField(
                            label: 'PHONE',
                            initialValue: '+213555555555',
                            validator: (value) => value!.isEmpty ? 'Phone is required' : null,
                          ),
                          CustomInputField(
                            label: 'PASSWORD',
                            isPassword: true,
                            controller: _passwordController,
                            validator: (value) => value!.isEmpty ? 'Password is required' : null,
                          ),
                          CustomInputField(
                            label: 'RE-TYPE PASSWORD',
                            isPassword: true,
                            controller: _rePasswordController,
                            validator: (value) {
                              if (value!.isEmpty) return 'Please re-type your password';
                              if (value != _passwordController.text) return 'Passwords do not match';
                              return null;
                            },
                          ),
                          CustomInputField(
                            label: 'EMAIL',
                            initialValue: 'example@gmail.com',
                            validator: (value) {
                              if (value!.isEmpty) return 'Email is required';
                              if (!value.contains('@')) return 'Invalid email format';
                              return null;
                            },
                          ),
                          CustomInputField(
                            label: 'DATE OF BIRTH',
                            initialValue: '01/01/2000',
                            validator: (value) => value!.isEmpty ? 'Date of birth is required' : null,
                          ),
                          CustomInputField(
                            label: 'ADDRESS',
                            maxLines: 3,
                            validator: (value) => value!.isEmpty ? 'Address is required' : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.mainGrey,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('NEXT'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Form is valid. Proceeding to next step.');
    } else {
      print('Form is invalid. Please correct the errors.');
    }
  }
}

