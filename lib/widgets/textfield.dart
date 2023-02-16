import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/colors.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final InputDecoration? inputDecoration;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final bool? enabled;
  final List<TextInputFormatter>? formatters;

  final String? hintText;

  const AppTextField(
      {this.controller,
      this.inputDecoration,
      this.obscureText,
      this.validator,
      this.focusNode,
      this.enabled,
      this.textCapitalization,
      this.onChanged,
      this.textInputType,
      this.formatters,
      this.hintText,
      Key? key})
      : super(key: key);

  static final defaultDecoration = defaultDecorationWithNoBoder.copyWith(
    focusedBorder: inputBoder,
    errorBorder: inputBoder,
    enabledBorder: inputBoder,
    focusedErrorBorder: inputBoder,
  );

  InputDecoration get decoration => inputDecoration ?? defaultDecoration;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(fontWeight: FontWeight.w500),
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: widget.decoration.copyWith(
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.normal),
        ),
        inputFormatters: widget.formatters,
        validator: widget.validator,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        keyboardType: widget.textInputType,
        onChanged: widget.onChanged,
        enabled: widget.enabled ?? true);
  }
}

final defaultDecorationWithNoBoder = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(borderRadius: inputBoder.borderRadius),
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  errorStyle: const TextStyle(fontSize: 14),
  suffixStyle: const TextStyle(
    color: Colors.red,
  ),
  focusedBorder: paleInputBorder,
  errorBorder: errorInputBorder,
  enabledBorder: paleInputBorder,
  focusedErrorBorder: paleInputBorder,
);

final inputBoder = OutlineInputBorder(
  borderSide: const BorderSide(width: 2.0, color: AppColors.borderColor),
  borderRadius: BorderRadius.circular(8.0),
);

/// makes sure in all state the border remains the same
final paleInputBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 2.0, color: AppColors.borderColor),
  borderRadius: BorderRadius.circular(8.0),
);

final errorInputBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 2.0, color: Colors.red),
  borderRadius: BorderRadius.circular(8.0),
);
