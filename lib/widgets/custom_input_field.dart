// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:stoop/widgets/style.dart';
import 'package:intl/intl.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final bool isPassword;
  final bool isBirthday;
  final int maxLines;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  const CustomInputField({
    Key? key,
    required this.label,
    this.initialValue,
    this.isPassword = false,
    this.isBirthday = false,
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
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    if (widget.isBirthday && widget.initialValue != null) {
      try {
        _selectedDate = DateFormat('dd/MM/yyyy').parse(widget.initialValue!);
      } catch (e) {
        // handle invalid
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime minDate = DateTime(now.year - 100);
    final DateTime maxDate = DateTime(now.year - 19, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? maxDate,
      firstDate: minDate,
      lastDate: maxDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.mainGrey,
              onPrimary: AppTheme.whiteColor,
              surface: AppTheme.whiteColor,
              onSurface: AppTheme.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  bool _isValidAge(String? value) {
    if (value == null || value.isEmpty) return false;
    try {
      final date = DateFormat('dd/MM/yyyy').parse(value);
      final now = DateTime.now();
      final age = now.year - date.year - 
          (now.month < date.month || (now.month == date.month && now.day < date.day) ? 1 : 0);
      return age >= 19;
    } catch (e) {
      return false;
    }
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
            readOnly: widget.isBirthday,
            onTap: widget.isBirthday ? () => _selectDate(context) : null,
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
                  : widget.isBirthday
                      ? const Icon(Icons.calendar_today)
                      : null,
            ),
            validator: widget.isBirthday
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Date of birth is required';
                    }
                    if (!_isValidAge(value)) {
                      return 'Must be at least 19 years old';
                    }
                    return null;
                  }
                : widget.validator,
          ),
        ],
      ),
    );
  }
}