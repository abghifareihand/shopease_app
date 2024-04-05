import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  // final TextEditingController controller;
  final String hintText;
  final Function() onTap;
  const CustomDropdown({
    super.key,
    // required this.controller,
    required this.hintText,
    required this.onTap,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 12.0,
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
