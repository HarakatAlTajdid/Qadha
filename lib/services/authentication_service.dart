import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/exceptions/authentication_exception.dart';
import 'package:qadha/models/welcome/phone_registration.dart';

final authServiceProvider = Provider((ref) => AuthenticationService());

class AuthenticationService {
  Future<bool> loginUser(
      PhoneRegistration registration) async {

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: registration.fakeMail(), password: registration.password);
    } on FirebaseAuthException catch (error) {
      String message;

      switch (error.code) {
        case 'user-not-found':
        case 'invalid-email':
        case 'wrong-password':
          {
            message = "Identifiants invalides";
          }
          break;

        case 'too-many-requests':
          {
            message = "Tu vas trop vite... Attends un peu.";
          }
          break;

        case 'user-disabled':
          {
            message = "Ce compte est banni du service";
          }
          break;

        default:
          {
            message = error.code;
          }
          break;
      }

      throw AuthenticationException(error.code, message);
    }

    return true;
  }

  Future<bool> registerUser(
      PhoneRegistration registration) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: registration.fakeMail(), password: registration.password);
    } on FirebaseAuthException catch (error) {
      String message = "Désolé, l'inscription a échoué\n(${error.code})";
      throw AuthenticationException(error.code, message);
    }

    return true;
  }

  Future<bool> doesUserExist(PhoneRegistration registration) async {
    final signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(registration.fakeMail());
    return signInMethods.isNotEmpty;
  }
}
