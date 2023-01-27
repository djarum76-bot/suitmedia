import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:suitmedia/util/app_theme.dart';

class AppButton extends StatelessWidget{
  const AppButton({super.key, this.radius, this.backgroundColor, this.textColor, required this.onPressed, required this.text, this.height, this.fontSize});

  final double? radius;
  final Color? backgroundColor;
  final Color? textColor;
  final String? text;
  final double? height;
  final double? fontSize;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height ?? 5.5.h,
      child: ElevatedButton(
        style: AppTheme.elevatedButton(radius ?? 16),
        onPressed: onPressed,
        child: Text(
          text!,
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: fontSize ?? 16.sp),
        ),
      ),
    );
  }
}