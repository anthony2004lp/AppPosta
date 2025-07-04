import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final String text;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Color.fromRGBO(162, 222, 252, 1),
      padding: EdgeInsets.all(18),
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
            fit: BoxFit.contain,
          ),
        ),
      ]),
    );
  }
}
