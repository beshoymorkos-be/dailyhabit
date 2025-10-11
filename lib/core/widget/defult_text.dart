import 'package:flutter/material.dart';

class DefultText extends StatelessWidget {
  const DefultText({super.key,required this.hint,required this.controller});
  final String hint;
final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintText:hint ,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
