import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qadha/ui/app/app_theme.dart';

class QadhaButton extends StatefulWidget {
  const QadhaButton(
      {Key? key,
      this.text = "QadhaButton",
      this.fontSize = 16,
      this.radius = 5,
      this.isLoading = false,
      this.isEnabled = true,
      required this.onTap})
      : super(key: key);

  final String text;
  final double fontSize;
  final double radius;
  final bool isLoading;
  final bool isEnabled;
  final Function() onTap;

  @override
  State<QadhaButton> createState() => _QadhaButtonState();
}

class _QadhaButtonState extends State<QadhaButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: AppTheme.deadPrimaryColor.withOpacity(0.2),
          onTap: widget.isLoading ? null : widget.onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: AppTheme.secundaryColor,
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.5.sp, horizontal: 5.sp),
              child: widget.isLoading
                  ? Center(
                      child: SizedBox(
                      width: 25.sp,
                      height: 25.sp,
                      child: CircularProgressIndicator(
                          strokeWidth: 2.5.sp < 3 ? 3 : 2.5.sp, color: AppTheme.primaryColor),
                    ))
                  : Center(
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: widget.fontSize.sp,
                          fontFamily: "Inter Regular",
                          color: widget.isEnabled
                              ? AppTheme.primaryColor
                              : AppTheme.deadColor,
                        ),
                      ),
                    ),
            ),
          )),
    );
  }
}
