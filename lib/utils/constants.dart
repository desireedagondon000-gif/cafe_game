import 'package:flutter/material.dart';

class Constants {
  static const List<Map<String, dynamic>> menu = [
    {"name": "Coffee", "icon": Icons.local_cafe},
    {"name": "Tea", "icon": Icons.emoji_food_beverage},
    {"name": "Cake", "icon": Icons.cake},
    {"name": "Cupcake", "icon": Icons.cake_outlined},
    {"name": "Sandwich", "icon": Icons.lunch_dining},
    {"name": "Juice", "icon": Icons.local_drink},
  ];

  static const List<Map<String, dynamic>> customers = [
    {"name": "Luna", "icon": Icons.face, "color": Colors.pink},
    {
      "name": "Milo",
      "icon": Icons.sentiment_very_satisfied,
      "color": Colors.orange,
    },
    {"name": "Daisy", "icon": Icons.child_care, "color": Colors.purple},
    {"name": "Noah", "icon": Icons.person, "color": Colors.blue},
    {"name": "Ella", "icon": Icons.emoji_people, "color": Colors.teal},
    {"name": "Leo", "icon": Icons.elderly, "color": Colors.brown},
  ];
}
