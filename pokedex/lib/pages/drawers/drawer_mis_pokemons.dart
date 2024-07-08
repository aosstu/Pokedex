import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pokedex/pages/details_page.dart';

class DrawerMisPokemons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Pokemons',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('pokemones')
            .where('capturado', isEqualTo: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No has capturado ningún Pokémon.'));
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              var pokemon = snapshot.data!.docs[index];
              return ListTile(
                leading: Icon(MdiIcons.pokeball),
                title: Text('${pokemon['nombre']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                          pokemonNombre: pokemon['nombre'], pokemon: pokemon),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: snapshot.data!.docs.length,
          );
        },
      ),
    );
  }
}
