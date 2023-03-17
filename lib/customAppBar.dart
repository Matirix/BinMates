import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const CustomAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage('images/BinMates-Logos_Initials.png'),
            size: 45,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title ?? 'Map',
          style: const TextStyle(
            fontFamily: 'Chivo',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00AD00));
  }

  /// Returns the preferred size of the app bar. Without this, it is an error.
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
