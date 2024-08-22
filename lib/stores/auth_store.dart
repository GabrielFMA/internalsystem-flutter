import 'package:internalsystem/models/text_error_model.dart';
import 'package:internalsystem/utils/error_messages.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @observable
  AuthModel? _user;

  @observable
  String _email = '';

  @observable
  String _password = '';

  @action
  void setEmail(String value) => _email = value;

  @action
  void setPassword(String value) => _password = value;

  @action
  AuthModel? get getUser => _user;

  @action
  Future<void> loginWithEmailAndPassword(
      TextErrorModel textError, Function onSuccess) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      if (await checkWebAccountAccess(userCredential.user?.uid)) {
        print('Usuario: ${userCredential.user?.uid}');
        print(_user?.name);
        print(_user?.email);
        onSuccess();
      } else {
        logout();
        textError.error =
            ErrorMessages.getErrorMessage('user-without-permission');
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      textError.error = ErrorMessages.getErrorMessage(e.code);
    } catch (e) {
      textError.error = 'Ocorreu um erro inesperado: ${e.toString()}';
    }
  }

  Future<bool> checkWebAccountAccess(String? document) async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(document)
          .get();

      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        if (data != null && data['isAdmin']) {
          _user = AuthModel(
            id: document,
            name: data['name'],
            email: data['email'],
          );
          return true;
        }
      }
    } catch (e) {
      print('Erro ao acessar o Firestore: $e');
      return false;
    }
    return false;
  }

  @action
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      _user = null;
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
