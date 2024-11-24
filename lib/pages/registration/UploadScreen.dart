// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stoop/providers/upload_provider.dart';
import 'package:stoop/routes/routes.dart';
import 'package:stoop/widgets/UploadItemWidget.dart';
import 'package:stoop/widgets/auth_progress_bar.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<UploadProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const ProgressBar(
                    currentStep: 2,
                    totalSteps: 2,
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.uploadItems.length,
                      itemBuilder: (context, index) {
                        final item = provider.uploadItems[index];
                        return UploadItemWidget(
                          item: item,
                          onImagePicked: (path) => provider.handleImagePicked(index, path),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    // onPressed: provider.canProceed ? () => provider.proceed(context) : null,
                    onPressed: () => {
                      Get.toNamed(AppRouter.verification_email)
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}