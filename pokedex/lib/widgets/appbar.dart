import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitulo;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.subtitulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          if (subtitulo != null)
            Text(
              subtitulo!,
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.red,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
