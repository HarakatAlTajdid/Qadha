import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/exceptions/authentication_exception.dart';
import 'package:qadha/models/welcome/phone_registration.dart';
import 'package:qadha/services/authentication_service.dart';

import 'verification_state.dart';

final verificationProvider =
    StateNotifierProvider<VerificationNotifier, VerificationState>((ref) {
  return VerificationNotifier(ref);
});

class VerificationNotifier extends StateNotifier<VerificationState> {
  final StateNotifierProviderRef<VerificationNotifier, VerificationState> _ref;

  VerificationNotifier(this._ref) : super(VerificationState.initial());

  Future<bool> confirmCode(PhoneRegistration registration, String code) async {
    state = state.copyWith(isWorking: true);
    
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: registration.verificationId!, smsCode: code);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      final String message;
      switch(error.code) {
        case "invalid-verification-code":
          message = "Code de confirmation invalide";
          break;
        default:
          message = "La confirmation a échoué\n(${error.code})";
          break;
      }

      state = state.copyWith(isWorking: false, formHasError: true, errorMessage: message);
      return false;
    }

    try {
      await _ref.read(authServiceProvider).registerUser(registration);
    }
    on AuthenticationException catch (error) {
      state = state.copyWith(isWorking: false, errorMessage: error.message);
      return false;
    }

    state = state.copyWith(isWorking: false);
    
    return true;
  }
}