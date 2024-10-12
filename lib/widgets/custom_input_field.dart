// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:stoop/widgets/style.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final bool isPassword;
  final int maxLines;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  const CustomInputField({
    Key? key,
    required this.label,
    this.initialValue,
    this.isPassword = false,
    this.maxLines = 1,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.grey,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: _controller,
            obscureText: widget.isPassword && _obscureText,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.grey200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}