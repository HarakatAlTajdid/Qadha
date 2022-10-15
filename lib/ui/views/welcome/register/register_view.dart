import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/welcome/phone_registration.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';

import '../account_box_view.dart';
import 'state/register_viewmodel.dart';

class RegisterView extends ConsumerWidget {
  RegisterView({this.checkSession = true, Key? key}) : super(key: key);

  final bool checkSession;

  final TextEditingController _codeController =
      TextEditingController(text: "33");
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> doCheckSession(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (checkSession && FirebaseAuth.instance.currentUser != null) {
      //await UserDataManager().getData(FirebaseAuth.instance.currentUser?.uid);
      // ignore: use_build_context_synchronously
      AutoRouter.of(context).popUntilRoot();
      // ignore: use_build_context_synchronously
      AutoRouter.of(context).replace(const HomeRoute());

      await Future.delayed(const Duration(seconds: 2));
    }

    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final state = ref.watch(registerProvider);

    return FutureBuilder(
      future: doCheckSession(context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Material(
          child: Container(
              color: AppTheme.secundaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  Expanded(
                              flex:
                                  MediaQuery.of(context).viewInsets.bottom != 0
                                      ? 0
                                      : state.formHasError
                                          ? 15
                                          : 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (MediaQuery.of(context).viewInsets.bottom == 0)
                            Column(
                              children: [
                                SizedBox(
                                    width: size.width / 1.3,
                                    child: Image.asset(
                                        "assets/images/welcome_logo.png")),
                                const SizedBox(height: 15),
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
                  if (snapshot.hasData)
                    Expanded(
                        flex: state.formHasError ? 14 : 6,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: AccountBoxView(
                              title: "Créer un compte",
                              subtitle: "Bienvenue sur Qadha",
                              codeController: _codeController,
                              numController: _numController,
                              passwordController: _passwordController,
                              interactiveText: "Connexion →",
                              onInteractiveTap: (_) {
                                AutoRouter.of(context).push(LoginRoute());
                              },
                              confirmWidget: Column(
                                children: [
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
                                  Container(
                                      height: 53.5,
                                      margin: const EdgeInsets.only(top: 15),
                                      child: QadhaButton(
                                          text: "C'est parti !",
                                          fontSize: 18,
                                          isLoading: state.isWorking,
                                          onTap: () async {
                                            var registration =
                                                PhoneRegistration(
                                                    _codeController.text,
                                                    _numController.text,
                                                    _passwordController.text);
                                            await ref
                                                .read(registerProvider.notifier)
                                                .registerUser(registration,
                                                    (vId) {
                                              registration.verificationId = vId;
                                              AutoRouter.of(context).push(
                                                  VerificationRoute(
                                                      registration: registration));
                                            });
                                          })),
                                ],
                              ),
                            ))),
                  SizedBox(height: snapshot.hasData ? 45 : 100)
                ],
              )),
        );
      },
    );
  }
}
