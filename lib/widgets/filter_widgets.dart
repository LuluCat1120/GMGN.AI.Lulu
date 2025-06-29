import 'package:flutter/material.dart';

class FilterWidgets {
  static Widget filterChip({Widget? child, IconData? icon, Color? iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E), 
        borderRadius: BorderRadius.circular(20)
      ),
      child: child ?? Icon(icon, color: iconColor, size: 20),
    );
  }

  static Widget timeButton(String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF3A3A3C) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
      ),
    );
  }

  static Widget buildListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Token', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          Text('Liq / Initial', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }
} 