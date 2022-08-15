import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qadha/models/exceptions/authentication_exception.dart';
import 'package:qadha/services/authentication_service.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/locator.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  bool stayConnected = false;
  
  bool isWorking = false;
  bool formHasError = false;
  String errorMessage = "";

  void navigateToStart(BuildContext context) {
    AutoRouter.of(context).pop();
  }

  void setStayConnected(bool value) {
    stayConnected = value;
    notifyListeners();
  }

  void loginWithCredentials(BuildContext context, String phoneCode, String phoneNumber, String password) async {
    formHasError = false;
    
    isWorking = true;
    notifyListeners();

    try {
      await _authenticationService.loginUser(phoneCode, phoneNumber, password);
    } on AuthenticationException catch(e) {
      formHasError = true;
      errorMessage = e.message;
    }

    isWorking = false;
    notifyListeners();   

    if (!formHasError) {
      // ignore: use_build_context_synchronously
      AutoRouter.of(context).popUntilRoot();
      // ignore: use_build_context_synchronously
      AutoRouter.of(context).replace(const HomeRoute());
    }
  }
}