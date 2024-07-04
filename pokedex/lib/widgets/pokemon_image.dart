import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageSearch extends StatefulWidget {
  @override
  _ImageSearchState createState() => _ImageSearchState();
}
class _ImageSearchState extends State<ImageSearch> {
  String? _imageUrl;
  String _searchText = '';

  Future<void> _searchImage(String searchText) async {
    final normalizedText = searchText.trim();

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
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Búsqueda de Imágenes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Ingresa el texto de búsqueda',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _searchImage(_searchText);
              },
              child: Text('Buscar'),
            ),
            if (_imageUrl != null) Image.network(_imageUrl!),
          ],
        ),
      ),
    ));
  }
}
