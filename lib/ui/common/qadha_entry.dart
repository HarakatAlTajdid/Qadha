import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qadha/ui/app/app_theme.dart';

class QadhaEntry extends StatefulWidget {
  const QadhaEntry(
      {Key? key,
      this.fontSize = 18,
      this.isPassword = false,
      this.hint = "",
      this.autofillHints,
      this.textInputAction = TextInputAction.done,
      required this.controller})
      : super(key: key);

  final double fontSize;
  final bool isPassword;
  final String hint;
  final List<String>? autofillHints;
  final TextInputAction textInputAction;
  final TextEditingController controller;

  @override
  State<QadhaEntry> createState() => _QadhaEntryState();
}

class _QadhaEntryState extends State<QadhaEntry> {
  bool isPasswordShown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          border: Border.all(color: AppTheme.deadColor),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      padding: const EdgeInsets.only(left: 15),
      child: TextField(
        controller: widget.controller,
        autocorrect: false,
        autofillHints: widget.autofillHints,
        textInputAction: widget.textInputAction,
        style: TextStyle(
            color: Colors.black,
            fontSize: widget.fontSize,
            fontFamily: "Inter Regular"),
        decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? Material(
                    color: AppTheme.primaryColor,
                    child: InkWell(
                      onTap: null,
                      child: Ink(
                        child: IconButton(
                            icon: Icon(
                                isPasswordShown
                                    ? MdiIcons.eyeOff
                                    : MdiIcons.eye,
                                color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                isPasswordShown = !isPasswordShown;
                              });
                            }),
                      ),
                    ),
                  )
                : null,
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
            border: InputBorder.none),
        inputFormatters:
            widget.isPassword ? [FilteringTextInputFormatter.deny(" ")] : [],
        obscureText: widget.isPassword && !isPasswordShown,
        enableSuggestions: !widget.isPassword,
      ),
    );
  }
}
