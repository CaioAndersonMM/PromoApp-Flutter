import 'package:cloud_firestore/cloud_firestore.dart';

class LikesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarLike(String productId, String userId) async {
    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    // Cria o documento se não existir e atualiza as listas de likes e dislikes
    await productDoc.set({
      'likes': FieldValue.arrayUnion([userId]),
      'dislikes': FieldValue.arrayRemove([userId]), // Remove dos dislikes se presente
    }, SetOptions(merge: true));
  }

  Future<void> removerLike(String productId, String userId) async {
    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    // Cria o documento se não existir e remove o like
    await productDoc.set({
      'likes': FieldValue.arrayRemove([userId]),
    }, SetOptions(merge: true));
  }

  Future<void> adicionarDislike(String productId, String userId) async {
    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    // Cria o documento se não existir e atualiza as listas de dislikes e likes
    await productDoc.set({
      'dislikes': FieldValue.arrayUnion([userId]),
      'likes': FieldValue.arrayRemove([userId]), // Remove dos likes se presente
    }, SetOptions(merge: true));
  }

  Future<void> removerDislike(String productId, String userId) async {
    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    // Cria o documento se não existir e remove o dislike
    await productDoc.set({
      'dislikes': FieldValue.arrayRemove([userId]),
    }, SetOptions(merge: true));
  }

  Future<int> obterQuantidadeLikes(String productId) async {
    DocumentSnapshot snapshot = await _firestore.collection('products').doc(productId).get();
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?; // Cast para Map<String, dynamic>
      List<dynamic> likes = data?['likes'] ?? []; // Obter a lista de likes
      return likes.length;
    }
    return 0; // Retorna 0 se o documento não existir
  }

  Future<int> obterQuantidadeDislikes(String productId) async {
    DocumentSnapshot snapshot = await _firestore.collection('products').doc(productId).get();
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?; // Cast para Map<String, dynamic>
      List<dynamic> dislikes = data?['dislikes'] ?? []; // Obter a lista de dislikes
      return dislikes.length;
    }
    return 0; // Retorna 0 se o documento não existir
  }
}
