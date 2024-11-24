
import 'package:flutter/material.dart';

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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
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