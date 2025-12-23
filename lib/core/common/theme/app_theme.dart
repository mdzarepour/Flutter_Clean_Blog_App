import 'package:blog/core/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.materialFirstBlue,
    filledButtonTheme: _getFilledButton(),
    appBarTheme: _getAppbarTheme(),
    bottomSheetTheme: _getBottomSheetTheme(),
    floatingActionButtonTheme: _getFloatinButtonTheme(),
    inputDecorationTheme: _getInpuTheme(),
    textButtonTheme: _getTextButtonTheme(),
    checkboxTheme: const CheckboxThemeData(),
    dividerTheme: _getDividerTheme(),
  );

  static AppBarThemeData _getAppbarTheme() {
    return AppBarThemeData(
      backgroundColor: AppColors.materialFirstBlue,
      iconTheme: IconThemeData(color: Colors.white, size: 30),
      titleTextStyle: AppTextTheme.white30PoppinsBold,
      centerTitle: true,
    );
  }

  static BottomSheetThemeData _getBottomSheetTheme() {
    return const BottomSheetThemeData(
      backgroundColor: AppColors.materialThirdBlue,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  static TextButtonThemeData _getTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        fixedSize: Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        elevation: 0,
        backgroundColor: AppColors.materialSoftGrey,
      ),
    );
  }

  static FilledButtonThemeData _getFilledButton() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: const Size.fromHeight(60),
        backgroundColor: AppColors.materialThirdBlue,
        textStyle: AppTextTheme.white17PoppinsRegular,
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
      errorStyle: AppTextTheme.grey15DmSansRegular,
      fillColor: AppColors.materialThirdBlue,
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      hintStyle: AppTextTheme.grey20DmSansRegular,
      enabledBorder: border(10),
      focusedBorder: border(20),
      border: border(10),
      errorBorder: border(10),
      focusedErrorBorder: border(20),
      disabledBorder: border(10),
    );
  }
}
