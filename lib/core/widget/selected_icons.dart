import 'package:flutter/material.dart';

class SelectedIcons extends StatelessWidget {
  const SelectedIcons({required this.imageName,super.key});
  final String imageName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: ImageIcon(AssetImage(imageName,)),
    );
  }
}