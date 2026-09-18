import 'package:flutter/material.dart';

class RenonPrimaryButton extends StatelessWidget {
  const RenonPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  static const _lime = Color(0xFFC6F135);
  static const _dark = Color(0xFF171B18);

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: _lime,
          foregroundColor: _dark,
          disabledBackgroundColor: const Color(0xFF4A4F48),
          disabledForegroundColor: const Color(0xFF8B918A),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        child: isLoading
            ? const SizedBox.square(
                dimension: 21,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: _dark,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  color: _dark,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.1,
                ),
              ),
      ),
    );
  }
}

class RenonSecondaryButton extends StatelessWidget {
  const RenonSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFF0D0F0D),
          foregroundColor: const Color(0xFFC6F135),
          side: const BorderSide(
            color: Color(0xFF303530),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFFC6F135),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}