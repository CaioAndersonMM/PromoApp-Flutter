import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> cadastrarUsuario({
    required String name,
    required String email,
    required String password,
    required String city,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      userCredential.user!.updateDisplayName(name);

      return "";

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'O e-mail já está cadastrado.';
      } else if (e.code == 'weak-password') {
        return 'A senha fornecida é muito fraca.';
      } else {
        return 'Erro no cadastro: ${e.message}';
      }

    } catch (e) {
      return 'Erro desconhecido: $e';

    }
  }

  Future<String> logarUsuario({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return "";

    } on FirebaseAuthException catch (e) {
      return 'Erro de autenticação: ${e.message}';
    }
  }

  String getUserName() {
  User? user = _firebaseAuth.currentUser;
  return user?.displayName ?? '';
}

}
