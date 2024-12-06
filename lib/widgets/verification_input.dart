import 'package:flutter/material.dart';
import 'package:stoop/widgets/style.dart';

class VerificationInput extends StatelessWidget {
  final Function(String) onChanged;

  const VerificationInput({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          4,
          (index) => SizedBox(
            width: 50,
            height: 50,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counterText: "",
                labelStyle: const TextStyle(
                  color: AppTheme.whiteColor,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppTheme.mainGrey,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppTheme.mainGrey,
                    )),
                filled: true,
                fillColor: AppTheme.whiteColor,
              ),
              style: const TextStyle(color: AppTheme.mainGrey),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  onChanged(value);
                  if (index < 3) {
                    FocusScope.of(context).nextFocus();
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
