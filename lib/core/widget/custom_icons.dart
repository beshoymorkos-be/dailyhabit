import 'package:flutter/material.dart';

class CustomIcons extends StatefulWidget {
  final Function(String) onIconSelected;
  const CustomIcons({super.key,required this.onIconSelected});

  @override
  State<CustomIcons> createState() => _CustomIconsState();
}

class _CustomIconsState extends State<CustomIcons> {
  String? _selectedIcon;

  final List<String> _image = [
   'eat',
    'eating',
    'gem',
    'lab',
    'reading',
    'reminder',
    'sports',
    'study',
    'tasks',
    'water',
    'yoga'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choose Icon",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: _image.length,
            itemBuilder: (context, index) {
              final image = _image[index];
              final isSelected = _selectedIcon == image;

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedIcon = image);
                  widget.onIconSelected(image);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                    border: isSelected
                        ? Border.all(color: Colors.blue, width: 3)
                        : null,
                  ),
                  child: Image.asset('assets/images/$image.png')
                ),
              );
            },
          ),
        ),

      ],
    );
  }
}
