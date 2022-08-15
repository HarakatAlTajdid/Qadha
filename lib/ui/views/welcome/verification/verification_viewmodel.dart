import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadha/models/exceptions/authentication_exception.dart';
import 'package:qadha/services/authentication_service.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/locator.dart';
import 'package:stacked/stacked.dart';

class VerificationViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  
  bool isWorking = false;
  final String phoneCode;
  final String phoneNumber;
  final String password;
  final String verificationId;

  bool formHasError = false;
  String errorMessage = "";

  VerificationViewModel(this.phoneCode, this.phoneNumber, this.password, this.verificationId);

  Future<void> confirmCode(BuildContext context, String code) async {
    isWorking = true;
    notifyListeners();
    
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

    } on FirebaseAuthException catch (error) {
      formHasError = true;
      isWorking = false;

      switch(error.code) {
        case "invalid-verification-code":
          errorMessage = "Code de confirmation invalide";
          break;
        default:
          errorMessage = "La confirmation a échoué\n(${error.code})";
          break;
      }

      notifyListeners();
      return;
    }

    try {
      await _authenticationService.registerUser(phoneCode, phoneNumber, password);
    }
    on AuthenticationException catch (error) {
      errorMessage = error.message;
      notifyListeners();
      return;
    }

    //await UserDataManager().getData(FirebaseAuth.instance.currentUser!.uid);
    // ignore: use_build_context_synchronously
    AutoRouter.of(context).replace(const HomeRoute());

    isWorking = false;
  }
}