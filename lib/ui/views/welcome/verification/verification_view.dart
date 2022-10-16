import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qadha/models/welcome/phone_registration.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:qadha/ui/views/welcome/verification/state/verification_viewmodel.dart';

class VerificationView extends ConsumerWidget {
  VerificationView(this.registration, {Key? key}) : super(key: key);

  final PhoneRegistration registration;

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verificationProvider);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.secundaryColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom == 0 ? size.height / 6 : size.height / 8),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(45))
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Veuillez entrer le code de confirmation envoyé par SMS\nau ${registration.prettyPhone()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Inter Regular",
                                color: AppTheme.secundaryColor,
                                fontSize: 22)),
                        const SizedBox(height: 20),
                        FractionallySizedBox(
                          widthFactor: 0.8,
                          child: PinCodeTextField(
                              controller: _textController,
                              appContext: context,
                              length: 6,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                selectedColor: AppTheme.metallicColor,
                                inactiveColor: AppTheme.deadColor,
                              ),
                              keyboardType: TextInputType.number,
                              textStyle: TextStyle(
                                  color: AppTheme.secundaryColor, fontSize: 22),
                              onChanged: (e) {}),
                        ),
                        if (state.formHasError)
                          Column(
                            children: [
                              const SizedBox(height: 7),
                              Text(state.errorMessage,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppTheme.alertColor, fontSize: 20)),
                              const SizedBox(height: 10),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.95,
                  child: SizedBox(
                    height: 53.5,
                    child: QadhaButton(
                      text: "Terminer l'inscription",
                      isLoading: state.isWorking,
                      onTap: () async {
                        if (await ref
                            .read(verificationProvider.notifier)
                            .confirmCode(registration, _textController.text)) {
                          AutoRouter.of(context).replace(const HomeRoute());
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40)
              ],
            ),
          )),
        ],
      ),
    );
  }
}
