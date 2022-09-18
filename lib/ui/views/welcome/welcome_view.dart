import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/services/authentication_service.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:stacked/stacked.dart';

import 'account_box_view.dart';
import 'welcome_viewmodel.dart';

class WelcomeView extends ConsumerWidget {
  WelcomeView({this.checkSession = true, Key? key}) : super(key: key);

  final bool checkSession;

final TextEditingController _codeController =
      TextEditingController(text: "33");
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<WelcomeViewModel>.reactive(
        builder: (context, model, child) => FutureBuilder(
              future: model.checkSession(context, checkSession),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return Material(
                  child: Container(
                      color: AppTheme.secundaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                              height: size.height /
                                  (MediaQuery.of(context).viewInsets.bottom != 0
                                      ? 6
                                      : 12)),
                          Expanded(
                              flex:
                                  MediaQuery.of(context).viewInsets.bottom != 0
                                      ? 0
                                      : model.formHasError
                                          ? 15
                                          : 7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (MediaQuery.of(context)
                                          .viewInsets
                                          .bottom ==
                                      0)
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
                                flex: model.formHasError ? 14 : 6,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: AccountBoxView(
                                      title: "Créer un compte",
                                      subtitle: "Bienvenue sur Qadha",
                                      codeController: _codeController,
                                      numController: _numController,
                                      passwordController: _passwordController,
                                      interactiveText: "Connexion →",
                                      onInteractiveTap: model.navigateToLoginPage,
                                      confirmWidget: Column(
                                        children: [
                                          if (model.formHasError)
                                            Column(
                                              children: [
                                                const SizedBox(height: 5),
                                                Text(model.errorMessage,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            AppTheme.alertColor,
                                                        fontSize: 14,
                                                        fontFamily:
                                                            "Inter Regular")),
                                              ],
                                            ),
                                          Container(
                                              height: 53.5,
                                              margin:
                                                  const EdgeInsets.only(top: 15),
                                              child: QadhaButton(
                                                  text: "C'est parti !",
                                                  fontSize: 18,
                                                  isLoading: model.isRegistering,
                                                  onTap: () async {
                                                    await model.registerUser(
                                                        context,
                                                        _codeController.text,
                                                        _numController.text,
                                                        _passwordController.text);
                                                  })),
                                        ],
                                      ),
                                    ))),
                          SizedBox(height: snapshot.hasData ? 45 : 100)
                        ],
                      )),
                );
              },
            ),
        viewModelBuilder: () => WelcomeViewModel(ref.read(authServiceProvider)));
  }  
}