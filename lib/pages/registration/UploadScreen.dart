// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stoop/providers/upload_provider.dart';
import 'package:stoop/routes/routes.dart';
import 'package:stoop/widgets/UploadItemWidget.dart';
import 'package:stoop/widgets/auth_progress_bar.dart';
import 'package:stoop/widgets/style.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainGrey,
      body: SafeArea(
        child: Consumer<UploadProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 6,
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/back_icon.svg',
                        width: 32,
                        height: 32,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Upload your files',
                          style: TextStyle(
                            color: AppTheme.whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'We need your real photo and your id card,\n please provide them!!',
                          style: TextStyle(color: AppTheme.whiteColor),
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.whiteColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        const ProgressBar(
                          currentStep: 2,
                          totalSteps: 2,
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: provider.uploadItems.length,
                            itemBuilder: (context, index) {
                              final item = provider.uploadItems[index];
                              return UploadItemWidget(
                                item: item,
                                onImagePicked: (path) =>
                                    provider.handleImagePicked(index, path),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            // onPressed: provider.canProceed ? () => provider.proceed(context) : null,
                            onPressed: () =>
                                {Get.toNamed(AppRouter.verification_number)},
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
