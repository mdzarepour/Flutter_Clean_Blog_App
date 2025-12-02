import 'package:blog/core/common/constants/app_colors.dart';
import 'package:blog/core/common/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final Color? color;
  const CustomInput({
    super.key,
    this.color,
    required this.hint,
    required this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.materialGrey,
      style: AppTextTheme.grey20DmSansRegular,
      decoration: InputDecoration(
        fillColor: color,
        hintText: hint,
        suffixIcon: Icon(color: AppColors.materialGrey, icon),
      ),
      validator: (input) {
        if (input!.isEmpty) {
          return 'please fill required field';
        }
        return null;
      },
    );
  }
}
