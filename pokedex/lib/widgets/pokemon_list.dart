import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pokedex/pages/details_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pokedex/services/firestore_service.dart';

class PokemonList extends StatelessWidget {
  final snapshot;
  final bool isPokedex;
  const PokemonList({Key? key, required this.snapshot, required this.isPokedex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.isPokedex) {
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
            child: Slidable(
              startActionPane: ActionPane(motion: ScrollMotion(), children: [
                SlidableAction(
                    icon: MdiIcons.pokeball,
                    label: 'Capturar',
                    backgroundColor: Colors.green,
                    onPressed: (context) {
                      FirestoreService().capturarPokemon(pokemon.id);
                    })
              ]),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    icon: MdiIcons.trashCan,
                    label: 'Eliminar',
                    backgroundColor: Colors.red,
                    onPressed: (context) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmar eliminación'),
                            content: Text(
                                '¿Estás seguro de que deseas eliminar este Pokémon?'),
                            actions: [
                              TextButton(
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Eliminar',
                                  style: TextStyle(color: Colors.red.shade900),
                                ),
                                onPressed: () {
                                  FirestoreService().borrarPokemon(pokemon.id);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
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
                              pokemonNombre: pokemon['nombre'],
                              pokemon: pokemon),
                        ));
                  }),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 3,
          color: Colors.grey,
        ),
        itemCount: snapshot.data!.docs.length,
      );
    } else {
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
            child: Slidable(
              startActionPane: ActionPane(motion: ScrollMotion(), children: [
                SlidableAction(
                    icon: MdiIcons.pokeball,
                    label: 'Liberar',
                    backgroundColor: Colors.blue.shade300,
                    onPressed: (context) {
                      FirestoreService().liberarPokemon(pokemon.id);
                    })
              ]),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    icon: MdiIcons.trashCan,
                    label: 'Eliminar',
                    backgroundColor: Colors.red.shade900,
                    onPressed: (context) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmar eliminación'),
                            content: Text(
                                '¿Estás seguro de que deseas eliminar este Pokémon?'),
                            actions: [
                              TextButton(
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Eliminar',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  FirestoreService().borrarPokemon(pokemon.id);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
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
                              pokemonNombre: pokemon['nombre'],
                              pokemon: pokemon),
                        ));
                  }),
            ),
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
}
