import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadha/services/authentication_service.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:stacked/stacked.dart';

class WelcomeViewModel extends BaseViewModel {
  final AuthenticationService _authService;
  
  bool isRegistering = false;
  bool formHasError = false;
  String errorMessage = "test";

  WelcomeViewModel(this._authService);

  void navigateToLoginPage(BuildContext context) {
    AutoRouter.of(context).push(LoginRoute());
  }

  Future<bool> checkSession(BuildContext context, bool check) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (check && FirebaseAuth.instance.currentUser != null) {
      //await UserDataManager().getData(FirebaseAuth.instance.currentUser?.uid);
      // ignore: use_build_context_synchronously
      AutoRouter.of(context).popUntilRoot();
      // ignore: use_build_context_synchronously
      AutoRouter.of(context).replace(const HomeRoute());

      await Future.delayed(const Duration(seconds: 2));

      return true;
    }

    return false;
  }

  Future<void> registerUser(BuildContext context, String phoneCode,
      String phoneNumber, String password) async {
    if (password.length < 6) {
      formHasError = true;
      errorMessage = "Mot de passe trop court";
      notifyListeners();
      return;
    }

    isRegistering = true;
    notifyListeners();

    final userExists =
        await _authService.doesUserExist(phoneCode, phoneNumber);

    if (userExists) {
      formHasError = true;
      errorMessage = "Ce compte existe déjà";

      isRegistering = false;
      notifyListeners();
    } else {
      final phone = "+$phoneCode $phoneNumber";
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        codeAutoRetrievalTimeout: (String verificationId) {},
        codeSent: (String verificationId, int? forceResendingToken) {
          AutoRouter.of(context).push(VerificationRoute(
              phoneCode: phoneCode,
              phoneNumber: phoneNumber,
              password: password,
              verificationId: verificationId));

          isRegistering = false;
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException error) {
          formHasError = true;

          switch (error.code) {
            case "invalid-phone-number":
              errorMessage = "Numéro de téléphone invalide";
              break;
            default:
              errorMessage = error.code;
              break;
          }

          isRegistering = false;
          notifyListeners();
        },
      );
    }

    isRegistering = false;
    notifyListeners();
  }
}
