import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/base.dart';
import 'package:todo/model/user_model.dart';
import 'package:todo/screens/signup/connector.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';

class SignUpViewModel extends BaseViewModel<SignUpConnector> {
  Future<void> signUP(
      String email, String password, String name, int age) async {
    try {
      connector!.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
          name: name, email: email, age: age, id: credential.user!.uid);

      FireBaseFunctions.addUserToFirestore(userModel).then((value) {
        // created();
        connector!.goToHome();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        connector!.showMessage(e.message ?? "");
      } else if (e.code == 'email-already-in-use') {
       connector!.showMessage(e.message??"");
      }
    } catch (e) {
     connector!.showMessage(e.toString());
    }
  }
}
