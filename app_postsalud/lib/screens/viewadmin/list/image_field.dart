import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageField extends StatefulWidget {
  final String imageDefault;
  final Function(String) onSelectedImage;

  const ImageField(
      {super.key, required this.imageDefault, required this.onSelectedImage});

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  File? _imagePlace;

  @override
  void initState() {
    super.initState();
    if (widget.imageDefault.isNotEmpty) {
      try {
        _imagePlace = File(widget.imageDefault);
      } catch (e) {
        print("Error al cargar la imagen: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: imagePicker,
          child: _imagePlace != null
              ? CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(_imagePlace!),
                )
              : Container(
                  width: 160,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.purple),
                  ),
                  child: const Icon(Icons.image, color: Colors.purple),
                ),
        ),
        TextButton(onPressed: imagePicker, child: const Text("Subir foto")),
      ],
    );
  }

  Future<void> imagePicker() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (imageFile != null) {
      setState(() {
        _imagePlace = File(imageFile.path);
      });

      widget.onSelectedImage(imageFile.path); // Guardar la ruta en fotoUrl
    }
  }
}
