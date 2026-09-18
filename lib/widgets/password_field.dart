import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  static const _fieldColor = Color(0xFF202520);
  static const _borderColor = Color(0xFF303530);
  static const _textColor = Colors.white;
  static const _mutedColor = Color(0xFF777E78);
  static const _accentColor = Color(0xFFC6F135);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscured,
      textInputAction: widget.textInputAction,
      autofillHints: const [AutofillHints.password],
      validator: widget.validator,

      // Makes the password itself bright and readable.
      style: const TextStyle(
        color: _textColor,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),

      cursorColor: _accentColor,

      decoration: InputDecoration(
        labelText: widget.label,
        hintText: 'Enter your password',

        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
          color: _mutedColor,
          size: 21,
        ),

        suffixIcon: IconButton(
          tooltip: _isObscured
              ? 'Show password'
              : 'Hide password',

          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },

          icon: Icon(
            _isObscured
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: _mutedColor,
            size: 21,
          ),
        ),

        filled: true,
        fillColor: _fieldColor,

        labelStyle: const TextStyle(
          color: Color(0xFF969D97),
        ),

        floatingLabelStyle: const TextStyle(
          color: _accentColor,
          fontWeight: FontWeight.w600,
        ),

        hintStyle: const TextStyle(
          color: Color(0xFF5F665F),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: _borderColor,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: _borderColor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: _accentColor,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFE57373),
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFE57373),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}