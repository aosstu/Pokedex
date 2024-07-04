// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/pages/home_page.dart';
import 'package:pokedex/pages/register.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  String errorMessage = '';
  String _imageUrl = '';

  Future<void> _searchImage(String searchText) async {
    final normalizedText = searchText.trim();

    final storageRef =
        FirebaseStorage.instance.ref().child('fondo/$normalizedText.jpg');

    try {
      final downloadUrl = await storageRef.getDownloadURL();
      setState(() {
        _imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Error al buscar la imagen: $e');
      setState(() {
        _imageUrl =
            'https://firebasestorage.googleapis.com/v0/b/cer3-70e13.appspot.com/o/fondo%2Ffondologin.jpg?alt=media&token=f2f9c770-162f-412d-81b0-76efa0e42558';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchImage('fondologin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackgroundImage(),
          _buildLoginForm(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: _imageUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(_imageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24.0),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Bienvenido a la ',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Pokedex',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Inicia sesión para continuar',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'Correo electrónico',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(fontSize: 18.0),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  try {
                    final newUser = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (newUser != null) {
                      setState(() {
                        errorMessage = '';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  } catch (e) {
                    setState(() {
                      errorMessage = 'El usuario o contraseña no son correctos';
                    });
                  }
                },
                child: const Text(
                  'Iniciar sesión',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF030FF8),
                    decoration: TextDecoration.underline,

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
