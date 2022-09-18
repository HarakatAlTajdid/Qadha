import 'package:flutter/material.dart';
import 'package:qadha/ui/app/app_theme.dart';

class QadhaButton extends StatefulWidget {
  const QadhaButton(
      {Key? key,
      this.text = "QadhaButton",
      this.fontSize = 18,
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
              padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 5),
              child: widget.isLoading
                  ? Center(
                      child: SizedBox(
                      width: 30,
                      child: CircularProgressIndicator(
                          strokeWidth: 3, color: AppTheme.primaryColor),
                    ))
                  : Center(
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: widget.fontSize,
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
