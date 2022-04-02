import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool isEditable;
  final bool disabled;
  final bool readOnly;
  CustomTextField({
    required this.icon,
    required this.hint,
    this.isEditable = false,
    this.disabled = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        enabled: !disabled,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
          ),
          suffixIcon: isEditable
              ? IconButton(
                  icon: Icon(Icons.mode_edit),
                  onPressed: () {},
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.amber),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.amber),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.amber),
          ),
        ),
        readOnly: readOnly,
      ),
    );
  }
}
