import 'package:flutter/material.dart';

class VTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int? maxLines;
  final TextInputAction? inputAction;
  final double? hight;
  final bool? enabled;
  const VTextField({
    required this.controller,
    required this.hint,
    this.hight,
    this.enabled,
    this.maxLines,
    this.inputAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hight ?? 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.12))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              enabled: enabled,
              textAlignVertical: TextAlignVertical.top,
              textInputAction: inputAction ?? TextInputAction.done,
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.4),
                      fontWeight: FontWeight.w300),
                  hintText: hint,
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }
}
