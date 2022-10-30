import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_entry.dart';
import 'package:qadha/ui/common/qadha_phone_input.dart';

class AccountBoxView extends StatefulWidget {
  const AccountBoxView(
      {
        this.redSubtitle = false,
        required this.title,
      required this.subtitle,
      required this.codeController,
      required this.numController,
      required this.passwordController,
      required this.interactiveText,
      required this.onInteractiveTap,
      required this.confirmWidget,
      Key? key})
      : super(key: key);

  final bool redSubtitle;
  final String title;
  final String subtitle;
  final TextEditingController codeController;
  final TextEditingController numController;
  final TextEditingController passwordController;
  final String interactiveText;
  final Function(BuildContext) onInteractiveTap;
  final Widget confirmWidget;

  @override
  State<AccountBoxView> createState() => _AccountBoxViewState();
}

class _AccountBoxViewState extends State<AccountBoxView> {
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.sp),
        Text(widget.title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Inter SemiBold")),
        SizedBox(height: 2.5.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.subtitle,
                style: TextStyle(
                    color: widget.redSubtitle ? Colors.red : Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    fontFamily: widget.redSubtitle ? "Inter Bold" : "Inter SemiBold")),
            if (widget.interactiveText.isNotEmpty)
              SizedBox(
                height: 32.sp,
                child: TextButton(
                  onPressed: () {
                    widget.onInteractiveTap(context);
                  },
                  child: Text(widget.interactiveText,
                      style: TextStyle(color: Colors.purple, fontSize: 13.sp)),
                ),
              ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(7.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20.sp, right: 15.sp),
                child: _buildHeader()),
             SizedBox(height: 5.sp),
            Divider(thickness: 2.sp, color: AppTheme.deadColor.withOpacity(0.45)),
             SizedBox(height: 8.sp),
            FractionallySizedBox(
              widthFactor: 0.92,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QadhaPhoneInput(widget.codeController, widget.numController),
                   SizedBox(height: 12.5.sp),
                  QadhaEntry(
                    controller: widget.passwordController,
                    hint: "Mot de passe",
                    fontSize: 16.sp,
                    isPassword: true,
                    autofillHints: widget.title == "Se connecter"
                        ?  [AutofillHints.password]
                        : null,
                    textInputAction: TextInputAction.done,
                  ),
                  widget.confirmWidget
                ],
              ),
            ),
             SizedBox(height: 15.sp),
          ],
        ));
  }
}
