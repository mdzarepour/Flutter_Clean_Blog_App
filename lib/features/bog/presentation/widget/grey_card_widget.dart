import 'package:blog/core/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class GreyCardWidget extends StatelessWidget {
  final Widget child;
  final bool isSelected;
  final void Function()? onTap;

  const GreyCardWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.materialThirdBlue,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 2,
              color: isSelected
                  ? AppColors.materialSoftGrey
                  : Colors.transparent,
            ),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
