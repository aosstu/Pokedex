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
}
