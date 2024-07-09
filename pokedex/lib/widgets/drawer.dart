import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pokedex/pages/drawers/mis_pokemons.dart';
import 'package:pokedex/pages/drawers/pokedex.dart';
import 'package:pokedex/pages/home_page.dart';
import 'package:pokedex/pages/login.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  String _getUserDisplayName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email ?? 'Prueba';
      final username = email.split('@')[0];

      String name = username;
      return name;
    } else {
      return 'sin usuario';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  child: Text(_getUserDisplayName()),
                ),
              ],
            ),
          ),
          ListTile(
            textColor: Colors.black,
            iconColor: Colors.red,
            title: Text('Mi Perfil'),
            leading: Icon(MdiIcons.accountCircle),
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer antes de navegar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          Divider(),
          ListTile(
            textColor: Colors.black,
            iconColor: Colors.red,
            title: Text('Mis pokémones'),
            leading: Icon(MdiIcons.inbox),
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer antes de navegar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MisPokemones()),
              );
            },
          ),
          Divider(),
          ListTile(
            textColor: Colors.black,
            iconColor: Colors.red,
            title: Text('Pokedex'),
            leading: Icon(MdiIcons.pokeball),
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer antes de navegar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pokedex()),
              );
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
              Navigator.pop(context); // Cierra el Drawer antes de navegar
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
