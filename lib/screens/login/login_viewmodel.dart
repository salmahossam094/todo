import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/base.dart';
import 'package:todo/screens/login/connector.dart';

class LoginViewModel extends BaseViewModel<LoginConnector> {

  Future<void> login(String email, String password) async {
    try {
      connector!.showLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // logged();
      connector!.goToHome();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // onError(e.message);
        connector!.showMessage(e.message??"");
      } else if (e.code == 'wrong-password') {
        // onError(e.message);
        connector!.showMessage(e.message??"");
      }
    }
  }
}
