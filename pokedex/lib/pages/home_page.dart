import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pokedex/pages/drawers/mis_pokemons.dart';
import 'package:pokedex/pages/drawers/pokedex.dart';
import 'package:pokedex/pages/login.dart';
import 'package:pokedex/services/firestore_service.dart';
import 'package:pokedex/widgets/appbar.dart';
import 'package:pokedex/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayName = 'Prueba'; // Inicializa con un valor predeterminado

  @override
  void initState() {
    super.initState();
    _getUserDisplayName();
  }

  void _getUserDisplayName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email ?? 'Prueba';
      final username = email.split('@')[0];
      setState(() {
        displayName = username;
      });
    } else {
      setState(() {
        displayName = 'Prueba';
      });
    }
  }

  int cantidadPokemon() {
    int num = 0;

    return num;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //APPBAR
        appBar: CustomAppBar(
          title: 'Perfil',
          subtitulo: displayName,
        ),

        //BODY
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Correo Electrónico:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${FirebaseAuth.instance.currentUser!.email}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('pokemones')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  // Obtiene la cantidad de documentos en la colección
                  int totalPokemonCount = snapshot.data!.docs.length;

                  return Column(
                    children: [
                      Text(
                        'Cantidad de Pokémones en tu Pókedex:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$totalPokemonCount',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('pokemones')
                    .where('capturado', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  // Obtiene la cantidad de documentos en la colección filtrada
                  int capturedPokemonCount = snapshot.data!.docs.length;

                  return Column(
                    children: [
                      Text(
                        'Cantidad de Pokémones capturados:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$capturedPokemonCount',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        //DRAWER
        drawer: DrawerWidget());
  }
}
