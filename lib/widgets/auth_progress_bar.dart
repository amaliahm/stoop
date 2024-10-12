import 'package:flutter/material.dart';
import 'package:stoop/widgets/style.dart';

class ProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProgressBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      child: Row(
        children: List.generate(totalSteps, (index) {
          final isCompleted = index < currentStep;
          final isCurrentStep = index == currentStep - 1;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted || isCurrentStep ? AppTheme.mainGrey : AppTheme.whiteColor,
                    border: Border.all(color: AppTheme.mainGrey),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isCompleted || isCurrentStep ? AppTheme.whiteColor : AppTheme.mainGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (index < totalSteps - 1 )
                  Expanded(
                    child: Container(
                      height: 2,
                      color: AppTheme.mainGrey,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}