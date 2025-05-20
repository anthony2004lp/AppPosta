import 'package:flutter/material.dart';

class MyPerfilScreen extends StatelessWidget {
  const MyPerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Pantalla de Mi Perfil',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
