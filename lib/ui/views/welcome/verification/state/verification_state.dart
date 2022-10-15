class VerificationState {
  final bool isWorking;
  final bool formHasError;
  final String errorMessage;

  VerificationState(
      {required this.isWorking,
      required this.formHasError,
      required this.errorMessage});

  factory VerificationState.initial() {
    return VerificationState(
        isWorking: false, formHasError: false, errorMessage: "Erreur inconnue");
  }

  VerificationState copyWith(
      {bool? isWorking, bool? formHasError, String? errorMessage}) {
    return VerificationState(
        isWorking: isWorking ?? this.isWorking,
        formHasError: formHasError ?? this.formHasError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
