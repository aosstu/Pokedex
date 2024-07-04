import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pokedex/pages/pokemon_agregar.dart';
import 'package:pokedex/services/firestore_service.dart';
import 'package:pokedex/widgets/pokemon_list.dart';

class TabPokedex extends StatefulWidget {
  const TabPokedex({super.key});

  @override
  State<TabPokedex> createState() => _TabPokedexState();
}

class _TabPokedexState extends State<TabPokedex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder(
          stream: FirestoreService().pokemones(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return PokemonList(snapshot: snapshot);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          MdiIcons.plus,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          MaterialPageRoute ruta = MaterialPageRoute(
            builder: (context) => AgregarPokemon(),
          );
          Navigator.push(context, ruta).then(
            (value) {
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
