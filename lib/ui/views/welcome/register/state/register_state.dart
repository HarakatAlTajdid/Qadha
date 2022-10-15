class RegisterState {
  final bool isWorking;
  final bool formHasError;
  final String errorMessage;

  RegisterState(
      {required this.isWorking,
      required this.formHasError,
      required this.errorMessage});

  factory RegisterState.initial() {
    return RegisterState(
        isWorking: false, formHasError: false, errorMessage: "Erreur inconnue");
  }

  RegisterState copyWith(
      {bool? isWorking, bool? formHasError, String? errorMessage}) {
    return RegisterState(
        isWorking: isWorking ?? this.isWorking,
        formHasError: formHasError ?? this.formHasError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
