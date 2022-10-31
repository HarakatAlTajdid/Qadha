import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qadha/models/welcome/phone_registration.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:qadha/ui/common/social_media_button.dart';
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
    final state = ref.watch(loginProvider);

    return Scaffold(
      backgroundColor: AppTheme.secundaryColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 50.sp,
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: AppTheme.secundaryColor,
        title: Text("retour",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 22.sp,
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
                SizedBox(height: 7.5.sp),
              Expanded(
                  flex: MediaQuery.of(context).viewInsets.bottom != 0 ? 0 : 12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (MediaQuery.of(context).viewInsets.bottom == 0)
                        Column(
                          children: [
                            SizedBox(
                                width: 0.3.sw,
                                child: Image.asset(
                                    "assets/images/qadha_white.png")),
                          ],
                        ),
                    ],
                  )),
              Expanded(
                  flex: 25,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.5.sp),
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
                            SizedBox(height: 5.sp),
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
                                                              SizedBox(height: 20.sp),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        SocialMediaButton("google"),
                                        SocialMediaButton("apple"),
                                      ]),
                                  SizedBox(height: 15.sp),
                            SizedBox(
                                height: 50.sp,
                                child: QadhaButton(
                                    text: "Connexion",
                                    fontSize: 16,
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
              SizedBox(height: 40.sp)
            ],
          )),
    );
  }
}
