class DeleteAccountState {
  final bool isWorking;
  final bool formHasError;
  final String errorMessage;

  DeleteAccountState(
      {required this.isWorking,
      required this.formHasError,
      required this.errorMessage});

  factory DeleteAccountState.initial() {
    return DeleteAccountState(
        isWorking: false, formHasError: false, errorMessage: "Erreur inconnue");
  }

  DeleteAccountState copyWith(
      {bool? isWorking, bool? formHasError, String? errorMessage}) {
    return DeleteAccountState(
        isWorking: isWorking ?? this.isWorking,
        formHasError: formHasError ?? this.formHasError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
