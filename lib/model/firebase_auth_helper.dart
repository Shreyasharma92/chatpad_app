import 'package:chatpadapp/model/auth_exception_handler.dart';
import 'package:chatpadapp/model/auth_result_status.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthHelper {
  final _auth = FirebaseAuth.instance;
  AuthResultStatus _status;

  Future<AuthResultStatus> createAccount({email, pass}) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> login({email, pass}) async {
    try {
      final authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);

      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  logout() {
    _auth.signOut();
  }
}
