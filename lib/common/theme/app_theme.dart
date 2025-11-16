import 'package:blog/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'app_texttheme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.materialFirstBlue,
    filledButtonTheme: _getFilledButton(),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.materialThirdBlue,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    ),
    floatingActionButtonTheme: _getFloatinButtonTheme(),
    inputDecorationTheme: _getInpuTheme(),
    checkboxTheme: const CheckboxThemeData(),
    dividerTheme: _getDividerTheme(),
  );

  static FilledButtonThemeData _getFilledButton() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        fixedSize: const Size.fromHeight(60),
        backgroundColor: AppColors.materialThirdBlue,
        textStyle: AppTexttheme.white17PoppinsRegular,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static FloatingActionButtonThemeData _getFloatinButtonTheme() {
    return FloatingActionButtonThemeData(
      elevation: 0,
      foregroundColor: AppColors.materialWhite,
      backgroundColor: AppColors.materialThirdBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
    );
  }

  static DividerThemeData _getDividerTheme() {
    return const DividerThemeData(
      thickness: 0,
      color: AppColors.materialSoftGrey,
    );
  }

  static InputDecorationTheme _getInpuTheme() {
    OutlineInputBorder border(double radius) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide.none,
    );
    return InputDecorationTheme(
      filled: true,
      errorStyle: AppTexttheme.grey15DmSansRegular,
      fillColor: AppColors.materialThirdBlue,
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      hintStyle: AppTexttheme.grey20DmSansRegular,
      enabledBorder: border(10),
      focusedBorder: border(20),
      border: border(10),
      errorBorder: border(10),
      focusedErrorBorder: border(20),
      disabledBorder: border(10),
    );
  }
}
