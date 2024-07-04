import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistWidget extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  const ChecklistWidget({required this.document});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Nombre: ${document['nombre']}'),
        ),
        ListTile(
          title: Text('Tipo: ${document['tipo']}'),
        ),
        ListTile(
          title: Text('Altura: ${document['altura']}'),
        ),
        ListTile(
          title: Text('Categoría: ${document['categoria']}'),
        ),
        ListTile(
          title: Text('Peso: ${document['peso']}'),
        ),
      ],
    );
  }
}
