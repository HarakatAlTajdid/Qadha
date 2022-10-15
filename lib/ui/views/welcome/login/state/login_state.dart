class LoginState {
  final bool isWorking;
  final bool formHasError;
  final String errorMessage;

  LoginState(
      {required this.isWorking,
      required this.formHasError,
      required this.errorMessage});

  factory LoginState.initial() {
    return LoginState(
        isWorking: false, formHasError: false, errorMessage: "Erreur inconnue");
  }

  LoginState copyWith(
      {bool? isWorking, bool? formHasError, String? errorMessage}) {
    return LoginState(
        isWorking: isWorking ?? this.isWorking,
        formHasError: formHasError ?? this.formHasError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
