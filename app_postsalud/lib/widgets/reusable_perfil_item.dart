import 'package:flutter/material.dart';

class UserProfileWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String nombres;
  final String apellidos;
  final String edad;
  final String dni;
  final String telefono;
  final String email;

  const UserProfileWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.nombres,
    required this.apellidos,
    required this.edad,
    required this.dni,
    required this.telefono,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w800,
                ),
              ),
              _buildProfileDetail('Nombres:', nombres),
              _buildProfileDetail('Apellidos:', apellidos),
              _buildProfileDetail('Edad:', edad),
              _buildProfileDetail('DNI:', dni),
              _buildProfileDetail('Teléfono:', telefono),
              _buildProfileDetail('Email:', email),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Text(
      '$label $value',
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
