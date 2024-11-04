import 'package:cloud_firestore/cloud_firestore.dart';

class CountPostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarPost(String userId) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);
    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userDoc);
      int currentPosts = 0;
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        currentPosts = data?['posts'] ?? 0;
      }
      transaction.set(userDoc, {'posts': currentPosts + 1}, SetOptions(merge: true));
    });
  }

  Future<void> apagarPost(String userId) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);
    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userDoc);
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        int currentPosts = data?['posts'] ?? 0;
        if (currentPosts > 0) {
          transaction.update(userDoc, {'posts': currentPosts - 1});
        }
      }
    });
  }

  Future<int> obterPostagens(String userId) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);
    DocumentSnapshot snapshot = await userDoc.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>?;
      return data?['posts'] ?? 0;
    }
    return 0;
  }
}
