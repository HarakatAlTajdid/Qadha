import 'package:flutter/material.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:qadha/ui/views/welcome/account_box_view.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _codeController =
      TextEditingController(text: "33");
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
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
                  SizedBox(height: size.height / 100 < 10 ? 10 : size.height / 100),
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
                    flex: model.formHasError ? 5 : 4,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: AccountBoxView(
                          title: "Se connecter",
                          subtitle: "Bon retour !",
                          codeController: _codeController,
                          numController: _numController,
                          passwordController: _passwordController,
                          interactiveText: "Inscription →",
                          onInteractiveTap: model.navigateToStart,
                          confirmWidget: Column(
                            children: [
                              const SizedBox(height: 5),
                              if (model.formHasError)
                                      Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Text(model.errorMessage,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppTheme.alertColor,
                                                  fontSize: 14,
                                                  fontFamily: "Inter Regular")),
                                        ],
                                      ),

                              const SizedBox(height: 2),
                              /*GestureDetector(
                                onTap: () {
                                  model.setStayConnected(!model.stayConnected);
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      child: Checkbox(
                                        value: model.stayConnected,
                                        checkColor: AppTheme.primaryColor,
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    AppTheme.secundaryColor),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        onChanged: (bool? value) {
                                          model.setStayConnected(value!);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 7.5),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 2),
                                        child: Text("Rester connecté",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: "Inter SemiBold",
                                                fontSize: 15)))
                                  ],
                                ),
                              ),*/
                              SizedBox(
                                  height: 53.5,
                                  child: QadhaButton(
                                      text: "se connecter",
                                      fontSize: 17,
                                      isLoading: model.isWorking,
                                      onTap: () => model.loginWithCredentials(
                                          context,
                                          _codeController.text,
                                          _numController.text,
                                          _passwordController.text))),
                            ],
                          ),
                        ))),
                const SizedBox(height: 65)
              ],
            )),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
