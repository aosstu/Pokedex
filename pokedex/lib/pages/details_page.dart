import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pokedex/widgets/appbar.dart';

class DetailsPage extends StatefulWidget {
  final String pokemonNombre;
  final dynamic pokemon;

  const DetailsPage({Key? key, required this.pokemonNombre, this.pokemon})
      : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    // Llamar a la función para buscar la imagen al iniciar la pantalla
    _searchImage(widget.pokemonNombre);
  }

  Future<void> _searchImage(String searchText) async {
    // Normalizar el texto de entrada
    final normalizedText = searchText.trim().toLowerCase();

    // Buscar la imagen en Firebase Storage
    final storageRef =
        FirebaseStorage.instance.ref().child('images/$normalizedText.png');

    try {
      final downloadUrl = await storageRef.getDownloadURL();
      setState(() {
        _imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Error al buscar la imagen: $e');
      setState(() {
        _imageUrl = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Pokedex'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mostrar la imagen encontrada encima de los detalles
          if (_imageUrl != null)
            Card(
              elevation: 4,
              margin: EdgeInsets.all(16),
              child: Image.network(_imageUrl!, fit: BoxFit.cover),
            ),
          // Detalles del Pokémon
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ${widget.pokemon['nombre']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Tipo: ${widget.pokemon['tipo']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Altura: ${widget.pokemon['altura']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Categoría: ${widget.pokemon['categoria']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Peso: ${widget.pokemon['peso']}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
