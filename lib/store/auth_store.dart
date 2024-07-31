import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_model.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @observable
  AuthModel? user;

  @observable
  late UserCredential userCredential;

  @observable
  String email = '';

  @observable
  String password = '';

  @action
  getUserCredential() {
    return userCredential;
  }

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  Future<void> loginWithEmailAndPassword(Function onSuccess) async {
    try {
      userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = AuthModel(
        userId: userCredential.user?.uid,
        displayName: userCredential.user?.displayName,
        email: userCredential.user?.email,
      );

      if (userCredential.user?.uid != null) {
        print('Usuario: ${userCredential.user?.uid}');
        onSuccess();
      }
    } catch (e) {
      print('Error logging in with email and password: $e');
    }
  }

  @action
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      user = null;
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
