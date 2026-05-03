import 'package:flutter/material.dart';

import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_typography.dart';

class AppTextFromField extends StatefulWidget {
  final String? label;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final bool readOnly;
  final bool isPhoneField;
  final String? Function(String?)? validator;


  const AppTextFromField({
    super.key,
     this.label,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.controller,
    this.readOnly = false,
    this.isPhoneField = false, this.validator, this.maxLength,
  });

  @override
  State<AppTextFromField> createState() => _AppTextFromFieldState();
}

class _AppTextFromFieldState extends State<AppTextFromField> {
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: AppTypography.bodyLarge(),
        ),
        const SizedBox(height: 12),
        TextFormField(

          maxLength: widget.maxLength,
          validator: widget.validator,
          readOnly: widget.readOnly,
          controller: widget.controller,
          obscureText: widget.obscureText ? isPassword : false,
          keyboardType: widget.keyboardType,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(

            prefixIcon: widget.isPhoneField
                ? Padding(
              padding: const EdgeInsets.only(left: 12, right: 8, top: 5, bottom: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🇧🇩', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  const Text(
                    '+88',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            )
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
              icon: Icon(isPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
              onPressed: () => setState(() => isPassword = !isPassword),
            )
                : null,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
            filled: true,
           fillColor:  theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),

              borderSide: BorderSide(color: AppColors.primary600, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}