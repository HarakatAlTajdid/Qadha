import 'package:flutter/material.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_entry.dart';
import 'package:qadha/ui/common/qadha_phone_input.dart';

class AccountBoxView extends StatefulWidget {
  const AccountBoxView({
    required this.title,
    required this.subtitle,
    required this.codeController,
    required this.numController,
    required this.passwordController,
    required this.interactiveText,
    required this.onInteractiveTap,
    required this.confirmWidget,
    Key? key}) : super(key: key);

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.subtitle,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: "Inter SemiBold")),
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
                padding: const EdgeInsets.only(left: 25, right: 10),
                child: _buildHeader()),
            const SizedBox(height: 7.5),
            Divider(thickness: 2, color: AppTheme.deadColor.withOpacity(0.45)),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.92,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QadhaPhoneInput(widget.codeController, widget.numController),
                  const SizedBox(height: 15),
                  QadhaEntry(
                    controller: widget.passwordController,
                    hint: "Mot de passe",
                    fontSize: 16,
                    isPassword: true,
                    autofillHints: widget.title == "Se connecter" ? const [AutofillHints.password] : null,
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
