import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/welcome/phone_registration.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:qadha/ui/views/welcome/account_box_view.dart';
import 'package:qadha/ui/views/welcome/login/state/login_viewmodel.dart';

class LoginView extends ConsumerWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _codeController =
      TextEditingController(text: "33");
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final state = ref.watch(loginProvider);

    return Scaffold(
      backgroundColor: AppTheme.secundaryColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: AppTheme.secundaryColor,
        title: Text("retour",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 22,
                fontFamily: "Roboto Condensed",
                color: AppTheme.primaryColor)),
        shadowColor: Colors.transparent,
      ),
      body: Container(
          color: AppTheme.secundaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (MediaQuery.of(context).viewInsets.bottom != 0)
                SizedBox(
                    height: size.height / 100 < 10 ? 10 : size.height / 100),
              const SizedBox(height: 15),
              Expanded(
                  flex: MediaQuery.of(context).viewInsets.bottom != 0 ? 0 : 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (MediaQuery.of(context).viewInsets.bottom == 0)
                        Column(
                          children: [
                            SizedBox(
                                width: size.width / 3.5,
                                child: Image.asset(
                                    "assets/images/qadha_white.png")),
                            const SizedBox(height: 20),
                            Text(
                                "L'application qui te permets de rattraper tes prières manquées.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 21,
                                    fontFamily: "Inter Regular")),
                          ],
                        ),
                    ],
                  )),
              Expanded(
                  flex: state.formHasError ? 5 : 4,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: AccountBoxView(
                        title: "Se connecter",
                        subtitle: "Bon retour !",
                        codeController: _codeController,
                        numController: _numController,
                        passwordController: _passwordController,
                        interactiveText: "Inscription →",
                        onInteractiveTap: (e) {
                          AutoRouter.of(context).pop();
                        },
                        confirmWidget: Column(
                          children: [
                            const SizedBox(height: 5),
                            if (state.formHasError)
                              Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Text(state.errorMessage,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppTheme.alertColor,
                                          fontSize: 14,
                                          fontFamily: "Inter Regular")),
                                ],
                              ),
                            const SizedBox(height: 20),
                            SizedBox(
                                height: 53.5,
                                child: QadhaButton(
                                    text: "Connexion",
                                    fontSize: 18.5,
                                    isLoading: state.isWorking,
                                    onTap: () async {
                                      final registration = PhoneRegistration(
                                          _codeController.text,
                                          _numController.text,
                                          _passwordController.text);
                                      if (await ref
                                          .read(loginProvider.notifier)
                                          .loginUser(registration)) {
                                        AutoRouter.of(context).popUntilRoot();
                                        AutoRouter.of(context)
                                            .replace(const HomeRoute());
                                      }
                                    })),
                          ],
                        ),
                      ))),
              const SizedBox(height: 65)
            ],
          )),
    );
  }
}
