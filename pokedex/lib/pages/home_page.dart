import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/services/firestore_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hola'),
      ),
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
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        var pokemon = snapshot.data!.docs[index];
                        return ListTile(
                          leading: Text('${pokemon['nombre']}'),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: snapshot.data!.docs.length);
                }
              })),
    );
  }
}
