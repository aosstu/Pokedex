import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pokedex/pages/details_page.dart';

class PokemonList extends StatelessWidget {
  final snapshot;

  const PokemonList({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var pokemon = snapshot.data!.docs[index];
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red, Colors.white],
              ),
              border: Border.all(
                color: Colors.black,
                width: 1,
              )),
          child: ListTile(
              leading: Icon(MdiIcons.pokeball),
              title: Text('${pokemon['nombre']}'),
              tileColor: Colors.transparent,
              trailing: SizedBox(
                height: 100, // Adjust the width as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(MdiIcons.paw),
                    Text(
                      'Detalles',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                          pokemonNombre: pokemon['nombre'], pokemon: pokemon),
                    ));
              }),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 3,
        color: Colors.grey,
      ),
      itemCount: snapshot.data!.docs.length,
    );
  }
}
