import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

      User? user = userCredential.user;
      if (user != null) {
        // Atualiza o displayName do usuário
        await user.updateDisplayName(name);

        // Cria um documento do usuário no Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'nickname': name,
          'city': city,
          'favoriteProducts': <String>[], // Lista de favoritos inicial (vazia)
        });
      }

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
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "";

    } on FirebaseAuthException catch (e) {
      return 'Erro de autenticação: ${e.message}';
    }
  }

  String getUserId() {
    User? user = _firebaseAuth.currentUser;
    return user?.uid ?? '';
  }

  String getUserName() {
    User? user = _firebaseAuth.currentUser;
    return user?.displayName ?? '';
  }
}
