import 'package:blog/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTexttheme {
  AppTexttheme._();

  static final TextStyle white30PoppinsBold = GoogleFonts.poppins(
    fontSize: 30,
    color: AppColors.materialWhite,
    fontWeight: FontWeight.w900,
  );

  static final TextStyle white17DmSansRegular = GoogleFonts.dmSans(
    fontSize: 17,
    color: AppColors.materialWhite,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle white15DmSansBold = GoogleFonts.dmSans(
    fontSize: 15,
    color: AppColors.materialWhite,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle grey15DmSansRegular = GoogleFonts.dmSans(
    fontSize: 15,
    color: AppColors.materialGrey,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle pink12DmSansBold = GoogleFonts.dmSans(
    fontSize: 12,
    color: AppColors.materialPink,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle white45PoppinsBold = GoogleFonts.poppins(
    fontSize: 45,
    color: AppColors.materialWhite,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle white17PoppinsRegular = GoogleFonts.poppins(
    fontSize: 17,
    color: AppColors.materialWhite,
    fontWeight: FontWeight.w400,
  );
}
