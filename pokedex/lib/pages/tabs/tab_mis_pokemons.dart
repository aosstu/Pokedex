import 'package:flutter/material.dart';

class TabMisPokemons extends StatefulWidget {
  const TabMisPokemons({super.key});

  @override
  State<TabMisPokemons> createState() => _TabMisPokemonsState();
}

class _TabMisPokemonsState extends State<TabMisPokemons> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Mis pokemons'),
    );
  }
}
