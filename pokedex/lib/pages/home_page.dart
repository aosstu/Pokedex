import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/pages/drawers/drawer_mis_pokemons.dart';
import 'package:pokedex/pages/drawers/drawer_pokedex.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pokedex/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayName = 'Prueba'; // Inicializar con un valor predeterminado

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Pokedex'),
        backgroundColor: Colors.red,
      ),
      //BODY
      body: Center(
        child: Text('Informacion cuenta'),
      ),
      //DRAWER
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2.0, color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(displayName),
                  ),
                ],
              ),
            ),
            //NAVEGACIÓN OTRAS VISTAS
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.red,
              title: Text('Mis pokemons'),
              leading: Icon(Icons.person),
              onTap: () {
                MaterialPageRoute rutaDrawers = MaterialPageRoute(
                  builder: (context) {
                    return DrawerMisPokemons();
                  },
                );
                Navigator.pop(context);
                Navigator.push(context, rutaDrawers);
              },
            ),
            Divider(),
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.red,
              title: Text('Pokedex'),
              leading: Icon(MdiIcons.pokeball),
              onTap: () {
                MaterialPageRoute rutaDrawers = MaterialPageRoute(
                  builder: (context) {
                    return DrawerPokedex();
                  },
                );
                Navigator.pop(context);
                Navigator.push(context, rutaDrawers);
              },
            ),
            Divider(),
            ListTile(
              textColor: Colors.black,
              iconColor: Colors.red,
              title: Text('Cerrar Sesión'),
              leading: Icon(MdiIcons.exitToApp),
              onTap: () {
                FirebaseAuth.instance.signOut();
                MaterialPageRoute rutaDrawers = MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                );
                Navigator.pop(context);
                Navigator.push(context, rutaDrawers);
              },
            ),
          ],
        ),
      ),
    );
  }
}
