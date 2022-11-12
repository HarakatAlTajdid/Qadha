import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qadha/models/welcome/phone_registration.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:qadha/ui/common/social_media_button.dart';

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
                  if (MediaQuery.of(context).viewInsets.bottom != 0)
                    SizedBox(height: 80.sp),
                  Expanded(
                      flex: MediaQuery.of(context).viewInsets.bottom != 0
                          ? 0
                          : state.formHasError
                              ? 10
                              : 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (MediaQuery.of(context).viewInsets.bottom == 0)
                            Column(
                              children: [
                                SizedBox(
                                    width: 0.8.sw,
                                    height: 0.15.sh,
                                    child: Image.asset(
                                        "assets/images/welcome_logo.png")),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.sp),
                                  child: Text(
                                      "L'application qui vous permet de rattraper des prières manquées.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontSize: 20.sp,
                                          fontFamily: "Inter Regular")),
                                ),
                              ],
                            ),
                        ],
                      )),
                  if (snapshot.hasData)
                    Expanded(
                        flex: state.formHasError ? 14 : 6,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.5.sp),
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
                                        SizedBox(height: 5.sp),
                                        Text(state.errorMessage,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AppTheme.alertColor,
                                                fontSize: 14.sp,
                                                fontFamily: "Inter Regular")),
                                      ],
                                    ),
                                  /*
                                  SizedBox(height: 20.sp),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        SocialMediaButton("google"),
                                        SocialMediaButton("apple"),
                                      ]),
                                  */
                                  SizedBox(height: 2.5.sp),
                                  Container(
                                      height: 50.sp,
                                      margin: EdgeInsets.only(top: 15.sp),
                                      child: QadhaButton(
                                          text: "C'est parti !",
                                          fontSize: 16,
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
                                                      registration:
                                                          registration));
                                            });
                                          })),
                                ],
                              ),
                            ))),
                  SizedBox(height: snapshot.hasData ? 40.sp : 100.sp)
                ],
              )),
        );
      },
    );
  }
}
