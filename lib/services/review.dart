import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> salvarAvaliacao(String productId, String review, double rating, String name) async {
    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    await productDoc.set({
      'reviews': FieldValue.arrayUnion([{
        'review': review,
        'rating': rating,
        'name': name,
      }]),
    }, SetOptions(merge: true));
  }

  Future<void> apagarAvaliacao(String productId, String review, double rating) async {
    User? user = _firebaseAuth.currentUser;
    String? username = user?.displayName ?? 'Anônimo';

    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    await productDoc.set({
      'reviews': FieldValue.arrayRemove([{
        'review': review,
        'rating': rating,
        'username': username,
      }]),
    }, SetOptions(merge: true));
  }

  Future<List<Map<String, dynamic>>> obterAvaliacoes(String productId) async {
    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    DocumentSnapshot snapshot = await productDoc.get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      // Converte a lista de avaliações para incluir review, rating e username
      List<Map<String, dynamic>> reviews = List<Map<String, dynamic>>.from(data?['reviews'] ?? []);
      return reviews;
    }
    return [];
  }
}
