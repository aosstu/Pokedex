import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        body: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/cer3-70e13.appspot.com/o/entrenadores%2Fentrenador.jfif?alt=media&token=27090579-3eea-4aa6-b04b-5cc6fe479e82'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            20), // Espacio entre la imagen y el resto de los elementos
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Correo Electrónico:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${FirebaseAuth.instance.currentUser!.email}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('pokemones')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          // Obtiene la cantidad de documentos en la colección
                          int totalPokemonCount = snapshot.data!.docs.length;

                          return Column(
                            children: [
                              Text(
                                'Cantidad de Pokémons en tu Pókedex:',
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
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('pokemones')
                            .where('capturado', isEqualTo: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          // Obtiene la cantidad de documentos en la colección filtrada
                          int capturedPokemonCount = snapshot.data!.docs.length;

                          return Column(
                            children: [
                              Text(
                                'Cantidad de Pokémons capturados:',
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        //DRAWER
        drawer: DrawerWidget());
  }
}
