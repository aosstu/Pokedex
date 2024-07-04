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
    _searchImage(widget.pokemonNombre);
  }

  Future<void> _searchImage(String searchText) async {
    final normalizedText = searchText.trim().toLowerCase();

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
          if (_imageUrl != null)
            Card(
              elevation: 4,
              margin: EdgeInsets.all(16),
              child: Image.network(_imageUrl!, fit: BoxFit.cover),
            ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), 
                  // Borde azul
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    Text(
                      '${widget.pokemon['nombre']}',
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.black, 
                        fontFamily: 'Roboto', 
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tipo: ${widget.pokemon['tipo']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ), 
                    Text(
                      'Altura: ${widget.pokemon['altura']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'Categoría: ${widget.pokemon['categoria']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      'Peso: ${widget.pokemon['peso']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.purple,
                      ),
                    ),
                  ]),
                ),
              ))
        ],
      ),
    );
  }
}
