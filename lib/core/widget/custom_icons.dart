import 'package:flutter/material.dart';

class CustomIcons extends StatefulWidget {
  const CustomIcons({super.key});

  @override
  State<CustomIcons> createState() => _CustomIconsState();
}

class _CustomIconsState extends State<CustomIcons> {
  IconData? _selectedIcon;


  final List<IconData> _icons = [
    Icons.eco, // النبات
    Icons.menu_book, // كتاب
    Icons.fitness_center, // جيم
    Icons.fitness_center_outlined,
    Icons.water_drop,
    Icons.water,
    Icons.wb_sunny,
    Icons.health_and_safety,
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
            itemCount: _icons.length,
            itemBuilder: (context, index) {
              final icon = _icons[index];
              final isSelected = _selectedIcon == icon;

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedIcon = icon);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                    border: isSelected
                        ? Border.all(color: Colors.blue, width: 3)
                        : null,
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: isSelected ? Colors.blue : Colors.black54,
                  ),
                ),
              );
            },
          ),
        ),

      ],
    );
  }
}
