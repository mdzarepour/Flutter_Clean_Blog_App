import 'package:animate_do/animate_do.dart';
import 'package:blog/common/constants/app_colors.dart';
import 'package:blog/common/theme/app_texttheme.dart';
import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  final String title;
  final String description;

  const OnboardingWidget({
    super.key,
    required this.description,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.materialFirstBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FadeInUp(
              from: 25,
              duration: Duration(seconds: 1),
              child: Text(
                style: AppTexttheme.white30PoppinsBold,
                textAlign: TextAlign.center,
                title,
              ),
            ),
            SizedBox(height: 30),
            FadeInUp(
              from: 25,
              duration: Duration(seconds: 1),
              delay: Duration(milliseconds: 100),
              child: Text(
                style: AppTexttheme.white17PoppinsRegular,
                textAlign: TextAlign.center,
                description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
