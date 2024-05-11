import 'package:flutter/material.dart';

/// A customized text field widget.
class MyTextField extends StatelessWidget {
  /// Constructs a [MyTextField].
  ///
  /// The [controller], [hintText], [obscureText], and [keyboardType] must not be null.
  const MyTextField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    super.key,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
  });

  /// The controller for editing the text.
  final TextEditingController controller;

  /// The text to display as a hint in the field when it is empty.
  final String hintText;

  /// Whether the text field should obscure the text being entered.
  final bool obscureText;

  /// The type of keyboard to display.
  final TextInputType keyboardType;

  /// An optional icon to display at the end of the field.
  final Widget? suffixIcon;

  /// Callback function triggered when the field is tapped.
  final VoidCallback? onTap;

  /// An optional icon to display at the beginning of the field.
  final Widget? prefixIcon;

  /// An optional function that validates the input value.
  final String? Function(String?)? validator;

  /// An optional focus node to control the focus of the field.
  final FocusNode? focusNode;

  /// An optional error message to display if validation fails.
  final String? errorMsg;

  /// An optional function called when the value of the field changes.
  final String? Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        errorText: errorMsg,
      ),
    );
  }
}
