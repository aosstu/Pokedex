import 'package:flutter/material.dart';

class DrawerMisPokemons extends StatefulWidget {
  const DrawerMisPokemons({super.key});

  @override
  State<DrawerMisPokemons> createState() => _DrawerMisPokemonsState();
}

class _DrawerMisPokemonsState extends State<DrawerMisPokemons> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Mis pokemons'),
    );
  }
}
