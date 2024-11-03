import 'package:cloud_firestore/cloud_firestore.dart';

class InterestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarInteresse(String userId, String interesse) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);

    DocumentSnapshot snapshot = await userDoc.get();

    final data = snapshot.data() as Map<String, dynamic>?; 
    List<String> interesses = List<String>.from(data?['interesses'] ?? []);

    if (!interesses.contains(interesse)) {
      await userDoc.set({
        'interesses': FieldValue.arrayUnion([interesse]),
      }, SetOptions(merge: true));
    }
  }


  Future<void> removerInteresse(String userId, String interesse) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);

    await userDoc.set({
      'interesses': FieldValue.arrayRemove([interesse]),
    }, SetOptions(merge: true));
  }

  Future<List<String>> obterInteresses(String userId) async {
    DocumentReference userDoc = _firestore.collection('users').doc(userId);

    DocumentSnapshot snapshot = await userDoc.get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data is Map<String, dynamic>) {
        List<String> interesses = List<String>.from(data['interesses'] ?? []);
        return interesses;
      } else {
        return [];
      }
    }
    return [];
  }
}
