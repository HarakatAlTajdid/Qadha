import 'package:flutter/material.dart';
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
        const SizedBox(height: 25),
        Text(widget.title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w400,
                fontFamily: "Inter SemiBold")),
        const SizedBox(height: 2.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.subtitle,
                style: TextStyle(
                    color: widget.redSubtitle ? Colors.red : Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: widget.redSubtitle ? "Inter Bold" : "Inter SemiBold")),
            if (widget.interactiveText.isNotEmpty)
              SizedBox(
                height: 32,
                child: TextButton(
                  onPressed: () {
                    widget.onInteractiveTap(context);
                  },
                  child: Text(widget.interactiveText,
                      style: const TextStyle(color: Colors.purple)),
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
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: _buildHeader()),
            const SizedBox(height: 5),
            Divider(thickness: 2, color: AppTheme.deadColor.withOpacity(0.45)),
            const SizedBox(height: 6),
            FractionallySizedBox(
              widthFactor: 0.92,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QadhaPhoneInput(widget.codeController, widget.numController),
                  const SizedBox(height: 12.5),
                  QadhaEntry(
                    controller: widget.passwordController,
                    hint: "Mot de passe",
                    fontSize: 16,
                    isPassword: true,
                    autofillHints: widget.title == "Se connecter"
                        ? const [AutofillHints.password]
                        : null,
                    textInputAction: TextInputAction.done,
                  ),
                  widget.confirmWidget
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ));
  }
}
