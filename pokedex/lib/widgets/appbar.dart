import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitulo; // Parámetro opcional para el subtítulo

  const CustomAppBar({
    Key? key,
    required this.title,
    this.subtitulo, // Subtítulo puede ser null si no se proporciona
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title),
          if (subtitulo != null) // Mostrar el subtítulo si se proporciona
            Text(
              subtitulo!,
              style: TextStyle(fontSize: 14.0),
            ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.red, // Color de fondo del app bar
      // Puedes personalizar más propiedades del AppBar aquí según tus necesidades
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
