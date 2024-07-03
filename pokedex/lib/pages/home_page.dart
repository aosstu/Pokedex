import 'package:flutter/material.dart';
import 'package:pokedex/pages/tabs/tab_mis_pokemons.dart';
import 'package:pokedex/pages/tabs/tab_pokedex.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Pokedex'),
            backgroundColor: Colors.red,
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.person),
                  text: 'Mis Pókemons',
                ),
                Tab(
                  icon: Icon(MdiIcons.pokeball),
                  text: 'Pokedex',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [TabMisPokemons(), TabPokedex()],
          ),
        ),
      ),
    );
  }
}
