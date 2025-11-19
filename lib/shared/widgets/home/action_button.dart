import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color primaryColor;
  final VoidCallback? onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.primaryColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: primaryColor),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
