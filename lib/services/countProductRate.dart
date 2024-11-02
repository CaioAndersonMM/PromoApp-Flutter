import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountProductRatingService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarAvaliacao(String userId) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userDoc);

      // Inicializa rating com 0 se o documento existir, mas não tiver o campo rating
      int currentRating = 0;
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?; // Certificando-se de que seja um Map
        currentRating = data?['rating'] ?? 0; // Usando 'data' para acessar o campo 'rating'
      }

      transaction.set(userDoc, {'rating': currentRating + 1}, SetOptions(merge: true));
    });
  }

  Future<void> apagarAvaliacao(String userId) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userDoc);

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?; // Certificando-se de que seja um Map
        int currentRating = data?['rating'] ?? 0; // Usando 'data' para acessar o campo 'rating'
        if (currentRating > 0) {
          transaction.update(userDoc, {'rating': currentRating - 1});
        }
      }
    });
  }

  Future<int> obterAvaliacao(String userId) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);
    DocumentSnapshot snapshot = await userDoc.get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>?; // Certificando-se de que seja um Map
      return data?['rating'] ?? 0; // Usando 'data' para acessar o campo 'rating'
    }
    return 0;
  }
}
