import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrawerMisPokemons extends StatefulWidget {
  const DrawerMisPokemons({Key? key}) : super(key: key);

  @override
  State<DrawerMisPokemons> createState() => _DrawerMisPokemonsState();
}

class _DrawerMisPokemonsState extends State<DrawerMisPokemons> {
  late User? _currentUser;
  List<String> _selectedPokemons = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  void _togglePokemonSelection(String pokemonId) {
    setState(() {
      if (_selectedPokemons.contains(pokemonId)) {
        _selectedPokemons.remove(pokemonId);
      } else {
        _selectedPokemons.add(pokemonId);
      }
    });
  }

  Future<void> _addSelectedPokemons() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .update({'pokemons': FieldValue.arrayUnion(_selectedPokemons)});
      print('Pokemons agregados correctamente');
      setState(() {
        _selectedPokemons.clear();
      });
    } catch (e) {
      print('Error al agregar los pokemons: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona tus Pokemons'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed:
                _selectedPokemons.isNotEmpty ? _addSelectedPokemons : null,
          ),
        ],
      ),
      body: Center(
        child: _currentUser != null
            ? StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('pokemones')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  List<DocumentSnapshot> pokemonDocs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: pokemonDocs.length,
                    itemBuilder: (context, index) {
                      String pokemonId = pokemonDocs[index].id;
                      String pokemonName = pokemonDocs[index]['nombre'];

                      bool isSelected = _selectedPokemons.contains(pokemonId);

                      return ListTile(
                        title: Text(pokemonName),
                        leading: Checkbox(
                          value: isSelected,
                          onChanged: (bool? value) {
                            _togglePokemonSelection(pokemonId);
                          },
                        ),
                      );
                    },
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
