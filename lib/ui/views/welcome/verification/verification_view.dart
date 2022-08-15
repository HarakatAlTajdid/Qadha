import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:stacked/stacked.dart';

import 'verification_viewmodel.dart';

class VerificationView extends StatefulWidget {
  const VerificationView(
      this.phoneCode, this.phoneNumber, this.password, this.verificationId,
      {Key? key})
      : super(key: key);

  final String phoneCode;
  final String phoneNumber;
  final String password;
  final String verificationId;

  @override
  // ignore: library_private_types_in_public_api
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerificationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                          "Entre le code envoyé par SMS\nau +${widget.phoneCode}${widget.phoneNumber}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Inter Regular",
                              color: AppTheme.secundaryColor, fontSize: 22)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FractionallySizedBox(
                    widthFactor: 0.75,
                    child: PinCodeTextField(
                        controller: _textController,
                        appContext: context,
                        length: 6,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                        ),
                        keyboardType: TextInputType.number,
                        textStyle: TextStyle(
                            color: AppTheme.secundaryColor, fontSize: 22),
                        onChanged: (e) {}),
                  ),
                  if (model.formHasError)
                    Column(
                      children: [
                        const SizedBox(height: 7),
                        Text(model.errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTheme.alertColor, fontSize: 20)),
                        const SizedBox(height: 10),
                      ],
                    ),
                ],
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.85,
              child: SizedBox(
                height: 53.5,
                child: QadhaButton(
                  text: "continuer",
                  isLoading: model.isWorking,
                  onTap: () async {
                    await model.confirmCode(context, _textController.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
      viewModelBuilder: () => VerificationViewModel(widget.phoneCode,
          widget.phoneNumber, widget.password, widget.verificationId),
    );
  }
}
