class AuthenticationException implements Exception {
  String id;
  String message;
  AuthenticationException(this.id, this.message);
}