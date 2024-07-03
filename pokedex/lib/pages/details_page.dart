import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/services/firestore_service.dart';
import 'package:pokedex/widgets/appbar.dart';

class DetailsPage extends StatelessWidget {
  final String pokemonNombre;
  final String id;
  const DetailsPage({Key? key, required this.pokemonNombre, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Pokedex', subtitulo: pokemonNombre),
      body: Center(
          child: StreamBuilder(
              stream: FirestoreService().pokemones(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Card.outlined(
                    child: Column(
                      children: [
                        Text('${id}'),
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
