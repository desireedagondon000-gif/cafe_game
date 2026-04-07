import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const MenuButton({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isPressed ? 0.95 : 1.0; // press animation

    final Color glowColor = (_isHovered || widget.isSelected)
        ? const Color(0x66FF4081)
        : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Transform.scale(
          scale: scale,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            width: 90,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: widget.isSelected ? Colors.pink : Colors.pink.shade200,
                width: widget.isSelected ? 3 : 2,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: glowColor, blurRadius: 10, spreadRadius: 2),
                const BoxShadow(
                  color: Colors.pinkAccent,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, size: 35, color: Colors.pink),
                const SizedBox(height: 5),
                Text(
                  widget.name,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
