import 'package:qadha/models/exceptions/authentication_exception.dart';
import 'package:qadha/models/welcome/phone_registration.dart';
import 'package:qadha/services/authentication_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_state.dart';

final loginProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref);
});

class LoginNotifier extends StateNotifier<LoginState> {
  final StateNotifierProviderRef<LoginNotifier, LoginState> _ref;

  LoginNotifier(this._ref) : super(LoginState.initial());

Future<bool> loginUser(PhoneRegistration registration) async {
    state = state.copyWith(isWorking: true, formHasError: false);
    
    try {
      await _ref.read(authServiceProvider).loginUser(registration);
    } on AuthenticationException catch(e) {
      state = state.copyWith(isWorking: false, formHasError: true, errorMessage: e.message);
      return false;
    }

    state = state.copyWith(isWorking: false);

    return true;
    
    /*
    if (!formHasError) {
      // ignore: use_build_context_synchronously
      AutoRouter.of(context).popUntilRoot();
      // ignore: use_build_context_synchronously
      AutoRouter.of(context).replace(const HomeRoute());
    }
    */
  }

}