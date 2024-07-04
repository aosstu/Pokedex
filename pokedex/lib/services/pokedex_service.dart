import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PokedexService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getCapturedPokemonDetailsStream(
      String userId) {
    // Obtiene el documento de la sesión del usuario como Stream
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .asyncMap((sessionSnapshot) async {
      if (!sessionSnapshot.exists) {
        throw Exception('Session document does not exist.');
      }

      // Obtiene la lista de IDs de los pokémon capturados
      List<String> capturedPokemonIds =
          List<String>.from(sessionSnapshot.get('pokemons'));

      // Obtiene los detalles de cada pokémon y devuelve la lista como Stream
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
