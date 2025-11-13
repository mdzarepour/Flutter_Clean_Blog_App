import 'package:blog/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_texttheme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData darkTheme = ThemeData(
    filledButtonTheme: _getFilledButton(),
    bottomSheetTheme: const BottomSheetThemeData(
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
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.materialThirdBlue,
      contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      hintStyle: GoogleFonts.dmSans(
        fontSize: 13,
        color: AppColors.materialWhite,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    );
  }
}
