import 'package:flutter/material.dart';

class ReusablePopupMenuItem extends PopupMenuEntry<dynamic> {
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  const ReusablePopupMenuItem({
    required this.onTap,
    required this.icon,
    required this.text,
  });

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(dynamic value) => false;

  @override
  State<StatefulWidget> createState() => _ReusablePopupMenuItemState();
}

class _ReusablePopupMenuItemState extends State<ReusablePopupMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Icon(widget.icon, color: Colors.black),
            SizedBox(width: 10),
            Text(widget.text),
          ],
        ),
      ),
    );
  }
}
