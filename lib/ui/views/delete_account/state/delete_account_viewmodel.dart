import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/exceptions/authentication_exception.dart';
import 'package:qadha/models/welcome/phone_registration.dart';
import 'package:qadha/services/authentication_service.dart';
import 'package:qadha/ui/views/delete_account/state/delete_account_state.dart';

final deleteAccountProvider =
    StateNotifierProvider<DeleteAccountNotifier, DeleteAccountState>((ref) {
  return DeleteAccountNotifier(ref);
});

class DeleteAccountNotifier extends StateNotifier<DeleteAccountState> {
  final StateNotifierProviderRef<DeleteAccountNotifier, DeleteAccountState>
      _ref;

  DeleteAccountNotifier(this._ref) : super(DeleteAccountState.initial());

  Future<bool> deleteUser(PhoneRegistration registration) async {
    state = state.copyWith(isWorking: true, formHasError: false);

    try {
      await _ref.read(authServiceProvider).loginUser(registration);
    } on AuthenticationException catch (e) {
      state = state.copyWith(
          isWorking: false, formHasError: true, errorMessage: e.message);
      return false;
    }

    await FirebaseAuth.instance.currentUser!.delete();

    state = state.copyWith(isWorking: false);

    return true;
  }
}
