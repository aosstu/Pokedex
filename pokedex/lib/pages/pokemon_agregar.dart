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
        title: Text('Agregar Pokemon', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: nombreCtrl,
                    decoration: InputDecoration(
                      hintText: 'Nombre',
                      border: InputBorder.none,
                    ),
                    validator: (nombre) {
                      if (nombre!.isEmpty) {
                        return 'El nombre es requerido';
                      }
                      if (nombre.length < 3) {
                        return 'El nombre debe tener más de 3 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: tipoCtrl,
                    decoration: InputDecoration(
                      hintText: 'Tipo',
                      border: InputBorder.none,
                    ),
                    validator: (tipo) {
                      if (tipo!.isEmpty) {
                        return 'El tipo es requerido';
                      }
                      if (tipo.length < 3) {
                        return 'El tipo debe tener más de 3 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: categoriaCtrl,
                    decoration: InputDecoration(
                      hintText: 'Categoría',
                      border: InputBorder.none,
                    ),
                    validator: (categoria) {
                      if (categoria!.isEmpty) {
                        return 'La categoría es requerida';
                      }
                      if (categoria.length < 3) {
                        return 'La categoría debe tener más de 3 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: pesoCtrl,
                    decoration: InputDecoration(
                      hintText: 'Peso',
                      border: InputBorder.none,
                    ),
                    validator: (peso) {
                      if (peso!.isEmpty) {
                        return 'El peso es requerido';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: alturaCtrl,
                    decoration: InputDecoration(
                      hintText: 'Altura',
                      border: InputBorder.none,
                    ),
                    validator: (altura) {
                      if (altura!.isEmpty) {
                        return 'La altura es requerida';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirestoreService().agregarPokemon(
                        nombreCtrl.text.trim(),
                        tipoCtrl.text.trim(),
                        categoriaCtrl.text.trim(),
                        pesoCtrl.text.trim(),
                        alturaCtrl.text.trim(),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Agregar Pokemon'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
