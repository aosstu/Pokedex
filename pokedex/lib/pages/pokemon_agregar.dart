import 'package:flutter/material.dart';
import 'package:pokedex/services/firestore_service.dart';

class AgregarPokemon extends StatefulWidget {
  const AgregarPokemon({super.key});

  @override
  State<AgregarPokemon> createState() => _AgregarPokemonState();
}

class _AgregarPokemonState extends State<AgregarPokemon> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController tipoCtrl = TextEditingController();
  TextEditingController categoriaCtrl = TextEditingController();
  TextEditingController pesoCtrl = TextEditingController();
  TextEditingController alturaCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Pokemon'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              //NOMBRE
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(
                  label: Text('Nombre'),
                ),
                validator: (nombre) {
                  if (nombre!.isEmpty) {
                    return 'El nombre es requerido';
                  }
                  if (nombre.length < 3) {
                    return 'El nombre debe ser de mas de 3 caracteres';
                  }
                  return null;
                },
              ),
              //TIPO
              TextFormField(
                controller: tipoCtrl,
                decoration: InputDecoration(
                  label: Text('Tipo'),
                ),
                validator: (tipo) {
                  if (tipo!.isEmpty) {
                    return 'El tipo es requerido';
                  }
                  if (tipo.length < 3) {
                    return 'El tipo debe ser de mas de 3 caracteres';
                  }
                  return null;
                },
              ),
              //CATEGORÍA
              TextFormField(
                controller: categoriaCtrl,
                decoration: InputDecoration(
                  label: Text('Categoría'),
                ),
                validator: (categoria) {
                  if (categoria!.isEmpty) {
                    return 'LA categoría es requerida';
                  }
                  if (categoria.length < 3) {
                    return 'LA categoría debe ser de mas de 3 caracteres';
                  }
                  return null;
                },
              ),
              //PESO
              TextFormField(
                controller: pesoCtrl,
                decoration: InputDecoration(
                  label: Text('Peso'),
                ),
                validator: (peso) {
                  if (peso!.isEmpty) {
                    return 'El peso es requerido';
                  }
                  return null;
                },
              ),
              //ALTURA
              TextFormField(
                controller: alturaCtrl,
                decoration: InputDecoration(
                  label: Text('Altura'),
                ),
                validator: (altura) {
                  if (altura!.isEmpty) {
                    return 'La altura es requerido';
                  }
                  return null;
                },
              ),
              //BOTÓN AGREGAR
              Container(
                margin: EdgeInsets.only(top: 30),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    'Agregar Pokemon',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      //CAMPO VÁLIDO
                      //INSERTAR DATOS
                      FirestoreService().agregarPokemon(
                        nombreCtrl.text.trim(),
                        tipoCtrl.text.trim(),
                        categoriaCtrl.text.trim(),
                        pesoCtrl.text.trim(),
                        alturaCtrl.text.trim(),
                      );
                      //VOLVER A LA PÁGINA ANTERIOR
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
