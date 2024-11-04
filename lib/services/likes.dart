import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LikesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var quantidadeLikes = 0.obs;
  var quantidadeDislikes = 0.obs;

  // Método para inicializar a contagem de likes e dislikes
  Future<void> inicializarContagem(String productId) async {
    quantidadeLikes.value = await obterQuantidadeLikes(productId);
    quantidadeDislikes.value = await obterQuantidadeDislikes(productId);
  }

  Future<void> adicionarLike(String productId, String userId) async {
    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    // Atualiza as listas de likes e dislikes
    await productDoc.set({
      'likes': FieldValue.arrayUnion([userId]),
      'dislikes': FieldValue.arrayRemove([userId]), // Remove dos dislikes se presente
    }, SetOptions(merge: true));

    // Atualiza a contagem de likes
    quantidadeLikes.value = await obterQuantidadeLikes(productId);
    quantidadeDislikes.value = await obterQuantidadeDislikes(productId); // Atualiza também os dislikes
  }

  Future<void> removerLike(String productId, String userId) async {
    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    // Remove o like
    await productDoc.set({
      'likes': FieldValue.arrayRemove([userId]),
    }, SetOptions(merge: true));

    // Atualiza a contagem de likes
    quantidadeLikes.value = await obterQuantidadeLikes(productId);
    quantidadeDislikes.value = await obterQuantidadeDislikes(productId); // Atualiza também os dislikes
  }

  Future<void> adicionarDislike(String productId, String userId) async {
    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    // Atualiza as listas de dislikes e likes
    await productDoc.set({
      'dislikes': FieldValue.arrayUnion([userId]),
      'likes': FieldValue.arrayRemove([userId]), // Remove dos likes se presente
    }, SetOptions(merge: true));

    // Atualiza a contagem de dislikes
    quantidadeDislikes.value = await obterQuantidadeDislikes(productId);
    quantidadeLikes.value = await obterQuantidadeLikes(productId); // Atualiza também os likes
  }

  Future<void> removerDislike(String productId, String userId) async {
    DocumentReference productDoc = _firestore.collection('products').doc(productId);

    // Remove o dislike
    await productDoc.set({
      'dislikes': FieldValue.arrayRemove([userId]),
    }, SetOptions(merge: true));

    // Atualiza a contagem de dislikes
    quantidadeDislikes.value = await obterQuantidadeDislikes(productId);
    quantidadeLikes.value = await obterQuantidadeLikes(productId); // Atualiza também os likes
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
