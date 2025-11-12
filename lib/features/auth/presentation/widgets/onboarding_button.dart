import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const OnboardingButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(onPressed: onPressed, child: Text(title)),
    );
  }
}
