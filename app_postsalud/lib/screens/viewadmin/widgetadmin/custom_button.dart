import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final String text;
  final Color color;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.imagePath,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Aquí se aplica el color correctamente
        padding: EdgeInsets.all(8),
      ),
      onPressed: onPressed,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        ClipOval(
          child: Image.asset(
            imagePath,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ]),
    );
  }
}
