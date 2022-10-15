import 'package:firebase_auth/firebase_auth.dart';
import 'package:qadha/models/welcome/phone_registration.dart';
import 'package:qadha/services/authentication_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'register_state.dart';

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier(ref);
});

class RegisterNotifier extends StateNotifier<RegisterState> {
  final StateNotifierProviderRef<RegisterNotifier, RegisterState> _ref;

  RegisterNotifier(this._ref) : super(RegisterState.initial());

  Future<void> registerUser(PhoneRegistration registration, Function(String) codeSentCallback) async {
    state = state.copyWith(isWorking: true);
    
    if (registration.password.length < 6) {
      state = state.copyWith(
          isWorking: false, formHasError: true, errorMessage: "Mot de passe trop court");
      return;
    }

    final userExists = await _ref
        .read(authServiceProvider)
        .doesUserExist(registration);
    if (userExists) {
      state = state.copyWith(
          isWorking: false,
          formHasError: true,
          errorMessage: "Ce compte existe déjà");
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: registration.prettyPhone(),
      verificationCompleted: (PhoneAuthCredential credential) async {},
      codeAutoRetrievalTimeout: (String verificationId) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        codeSentCallback(verificationId);
        state = state.copyWith(isWorking: false);
      },
      verificationFailed: (FirebaseAuthException error) {
        final String message;
        switch (error.code) {
          case "invalid-phone-number":
            message = "Numéro de téléphone invalide";
            break;
          default:
            message = error.code;
            break;
        }

        state = state.copyWith(isWorking: false, formHasError: true, errorMessage: message);
      },
    );
  }
}
