import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(40, 157, 137, 1),
        title: Row(
          children: [
            SizedBox(
              width: 40,
              child: MaterialButton(
                onPressed: () {
                  showMenu(
                    context: context,
                    position: const RelativeRect.fromLTRB(0, 65, 0, 50),
                    items: [
                      const PopupMenuItem(
                        value: 1,
                        child: Text('data'),
                      ),
                    ],
                  ).then((value) {
                    return value != null ? null : 'Opción seleccionada: $value';
                  });
                },
                child: const Icon(Icons.menu, size: 20),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'BIENVENIDO',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(218, 255, 249, 1),
          child: Column(
            children: [
              Container(),
              Container(
                child: const Text(
                  'InformateMás',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
              ),
              Row(),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
                color: Colors.pink,
                child: const Text(
                  'Regresar a Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
