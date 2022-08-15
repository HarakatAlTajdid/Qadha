import 'package:firebase_auth/firebase_auth.dart';
import 'package:qadha/models/exceptions/authentication_exception.dart';

class AuthenticationService {
  Future<bool> loginUser(
      String phoneCode, String phoneNumber, String password) async {
    //UserCredential credential;

    final fakeMail = "$phoneCode${phoneNumber.replaceAll(" ", "")}@gmail.com";

    try {
      /*credential = */await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: fakeMail, password: password);
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

    //await UserDataManager().getData(credential.user?.uid);

    return true;
  }

  Future<bool> registerUser(
      String phoneCode, String phoneNumber, String password) async {
    final fakeMail = "$phoneCode${phoneNumber.replaceAll(" ", "")}@gmail.com";
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: fakeMail, password: password);
    } on FirebaseAuthException catch (error) {
      String message = "Désolé, l'inscription a échoué\n(${error.code})";
      throw AuthenticationException(error.code, message);
    }

    return true;
  }

   Future<bool> doesUserExist(String phoneCode, String phoneNumber) async {
    final fakeMail = "$phoneCode${phoneNumber.replaceAll(" ", "")}@gmail.com";
    final signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(fakeMail);
    return signInMethods.isNotEmpty;
  }
}
