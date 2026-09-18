import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/renon_spacing.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({
    super.key,
    required this.controller,
    this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.oneTimeCode],
      textAlign: TextAlign.center,
      maxLength: 6,
      validator: validator,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            letterSpacing: 0,
            fontWeight: FontWeight.w900,
          ),
      decoration: const InputDecoration(
        counterText: '',
        hintText: '000000',
        contentPadding: EdgeInsets.symmetric(
          horizontal: RenonSpacing.md,
          vertical: RenonSpacing.lg,
        ),
      ),
    );
  }
}
