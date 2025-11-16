import 'package:blog/common/constants/app_colors.dart';
import 'package:blog/common/theme/app_texttheme.dart';
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  const AuthField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.materialGrey,
      style: AppTexttheme.grey20DmSansRegular,
      decoration: InputDecoration(
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
