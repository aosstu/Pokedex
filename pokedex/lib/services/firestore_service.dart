import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Stream<QuerySnapshot> pokemones() {
    return FirebaseFirestore.instance.collection('pokemones').snapshots();
  }

  Stream<DocumentSnapshot> getPokemonDetails(String id) {
    return FirebaseFirestore.instance
        .collection('pokemones')
        .doc(id)
        .snapshots();
  }

  Future<void> agregarPokemon(String nombre, String tipo, String categoria,
      String peso, String altura) {
    return FirebaseFirestore.instance.collection('pokemones').doc().set({
      'nombre': nombre,
      'tipo': tipo,
      'categoria': categoria,
      'peso': peso,
      'altura': altura,
    });
  }

  Stream<DocumentSnapshot> getUserPokemons(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots();
  }

  Future<List<QueryDocumentSnapshot>> searchPokemonsById(String id) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('pokemones')
          .where('id', isEqualTo: id)
          .get();

      return querySnapshot.docs;
    } catch (e) {
      // Manejo de errores
      print('Error al buscar pokemones por ID: $e');
      return []; 
    }
  }

  Future<void> borrarPokemon(String docId) {
    return FirebaseFirestore.instance
        .collection('pokemones')
        .doc(docId)
        .delete();
  }
}
