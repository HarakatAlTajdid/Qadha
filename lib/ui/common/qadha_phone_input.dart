import 'package:flutter/material.dart';
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
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          border: Border.all(color: AppTheme.deadColor),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            padding: const EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
                color: AppTheme.secundaryColor,
                borderRadius: BorderRadius.circular(7.5)),
            child: Row(
              children: [
                Text("+",
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                const SizedBox(width: 5),
                SizedBox(
                    width: 40,
                    child: TextField(
                      controller: widget.codeController,
                      autofillHints: const [
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
                          fontWeight: FontWeight.w500, fontSize: 18),
                      keyboardType: TextInputType.number,
                    )),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: (size.width / 1.75 > 150) ? 150 : (size.width / 1.75),
            child: TextField(
              controller: widget.numController,
              autocorrect: false,
              autofillHints: const [AutofillHints.telephoneNumberNational],
              textInputAction: TextInputAction.next,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Inter Regular",
                  fontSize: 18),
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
