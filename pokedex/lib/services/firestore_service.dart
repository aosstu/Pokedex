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
}
