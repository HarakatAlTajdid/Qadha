import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qadha/ui/app/app_theme.dart';

class QadhaPhoneInput extends StatefulWidget {
   const QadhaPhoneInput(
    this.codeController,
    this.numController, {
    Key? key,
  }) : super(key: key);

  final TextEditingController codeController;
  final TextEditingController numController;

  @override
  State<QadhaPhoneInput> createState() => _QadhaPhoneInputState();
}

class _QadhaPhoneInputState extends State<QadhaPhoneInput> {
  bool isPasswordShown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          border: Border.all(color: AppTheme.deadColor),
          borderRadius:  const BorderRadius.all(Radius.circular(3))),
      padding: EdgeInsets.only(left: 15.sp),
      child: Row(
        children: [
          Container(
            margin:  EdgeInsets.symmetric(vertical: 10.sp),
            padding:  EdgeInsets.only(left: 10.sp, right: 5.sp),
            decoration: BoxDecoration(
                color: AppTheme.secundaryColor,
                borderRadius: BorderRadius.circular(7.5)),
            child: Row(
              children: [
                Text("+",
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp)),
                 SizedBox(width: 5.sp),
                SizedBox(
                    width: 35.sp,
                    child: TextField(
                      controller: widget.codeController,
                      autofillHints:  const [
                        AutofillHints.telephoneNumberCountryCode
                      ],
                      decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "33",
                          hintStyle: TextStyle(
                            color: AppTheme.deadColor,
                          )),
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500, fontSize: 17.sp),
                      keyboardType: TextInputType.number,
                    )),
              ],
            ),
          ),
           SizedBox(width: 10.sp),
          SizedBox(
            width: 0.35.sw,
            child: TextField(
              controller: widget.numController,
              autocorrect: false,
              autofillHints:  const [AutofillHints.telephoneNumberNational],
              textInputAction: TextInputAction.next,
              style:  TextStyle(
                  color: Colors.black,
                  fontFamily: "Inter Regular",
                  fontSize: 17.sp),
              decoration: InputDecoration(
                  hintText: "6 11 12 13 14",
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
                  border: InputBorder.none),
              keyboardType: TextInputType.phone,
              enableSuggestions: false,
            ),
          ),
        ],
      ),
    );
  }
}
