import 'package:flutter/material.dart';
import 'package:pokedex/services/firestore_service.dart';

class AgregarPokemon extends StatefulWidget {
  const AgregarPokemon({super.key});

  @override
  State<AgregarPokemon> createState() => _AgregarPokemonState();
}

class _AgregarPokemonState extends State<AgregarPokemon> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController categoriaCtrl = TextEditingController();
  TextEditingController pesoCtrl = TextEditingController();
  TextEditingController alturaCtrl = TextEditingController();
  String tipo = '';
  String tipo2 = '';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Pokemon',
          style: TextStyle(color: Colors.white),
        ),
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
                  child: FutureBuilder(
                    future: FirestoreService().tipos(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Cargando tipos');
                      } else {
                        var tipos = snapshot.data!.docs;
                        return DropdownButtonFormField<String>(
                          value: tipo == '' ? null : tipo,
                          decoration: InputDecoration(labelText: 'Tipo'),
                          items: tipos.map<DropdownMenuItem<String>>((tipo) {
                            return DropdownMenuItem<String>(
                              child: Text(tipo['tipo']),
                              value: tipo['tipo'],
                            );
                          }).toList(),
                          onChanged: (tipoSeleccionado) {
                            setState(() {
                              this.tipo = tipoSeleccionado!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'El tipo es requerido';
                            }
                            return null;
                          },
                        );
                      }
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
                  child: FutureBuilder(
                    future: FirestoreService().tipos(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Cargando tipos');
                      } else {
                        var tipos2 = snapshot.data!.docs;
                        return DropdownButtonFormField<String>(
                          value: tipo2 == '' ? null : tipo2,
                          decoration: InputDecoration(
                            labelText: 'Segundo Tipo (Opcional)',
                          ),
                          items: tipos2.map<DropdownMenuItem<String>>((tipo2) {
                            return DropdownMenuItem<String>(
                              child: Text(tipo2['tipo']),
                              value: tipo2['tipo'],
                            );
                          }).toList(),
                          onChanged: (tipoSeleccionado) {
                            setState(() {
                              this.tipo2 = tipoSeleccionado!;
                            });
                          },
                          validator: (value) {
                            return null;
                          },
                        );
                      }
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
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: pesoCtrl,
                    decoration: InputDecoration(
                      hintText: 'Peso (Kg)',
                      border: InputBorder.none,
                    ),
                    validator: (peso) {
                      if (peso!.isEmpty) {
                        return 'El peso es requerido';
                      }
                      if (double.tryParse(peso.replaceAll(',', '.')) == null) {
                        return 'Por favor ingresa un número válido';
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
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: alturaCtrl,
                    decoration: InputDecoration(
                      hintText: 'Altura (m)',
                      border: InputBorder.none,
                    ),
                    validator: (altura) {
                      if (altura!.isEmpty) {
                        return 'La altura es requerida';
                      }
                      if (double.tryParse(altura.replaceAll(',', '.')) ==
                          null) {
                        return 'Por favor ingresa un número válido';
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
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      double peso = double.parse(
                          pesoCtrl.text.trim().replaceAll(',', '.'));
                      double altura = double.parse(
                          alturaCtrl.text.trim().replaceAll(',', '.'));

                      // Convertir los valores a enteros
                      int pesoInt = peso.round();
                      int alturaInt = altura.round();

                      FirestoreService().agregarPokemon(
                        nombreCtrl.text.trim(),
                        this.tipo,
                        categoriaCtrl.text.trim(),
                        pesoInt,
                        alturaInt,
                        tipo2: this.tipo2,
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
