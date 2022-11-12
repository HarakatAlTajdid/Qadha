import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qadha/ui/app/app_theme.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton(this.socialMedia, {Key? key}) : super(key: key);

  final String socialMedia;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.secundaryColor, width: 1.75.sp)),
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 25.sp,
        height: 25.sp,
        child: SvgPicture.asset("assets/images/icons/$socialMedia.svg")));
  }
}