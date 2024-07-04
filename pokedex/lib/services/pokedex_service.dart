// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PokedexService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getCapturedPokemonDetailsStream(
      String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .asyncMap((sessionSnapshot) async {
      if (!sessionSnapshot.exists) {
        throw Exception('Session document does not exist.');
      }

      List<String> capturedPokemonIds =
          List<String>.from(sessionSnapshot.get('pokemons'));

      List<Map<String, dynamic>> capturedPokemonDetails = [];
      for (var pokemonId in capturedPokemonIds) {
        DocumentSnapshot pokemonSnapshot =
            await _firestore.collection('pokemones').doc(pokemonId).get();

        if (pokemonSnapshot.exists) {
          capturedPokemonDetails
              .add(pokemonSnapshot.data() as Map<String, dynamic>);
        }
      }

      return capturedPokemonDetails;
    });
  }
}
