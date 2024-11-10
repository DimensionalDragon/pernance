import 'package:flutter/material.dart';

class PernanceEditableText extends StatefulWidget {
  const PernanceEditableText({super.key, this.keyboardType = TextInputType.text, this.validator, this.controller, this.style});

  final TextInputType keyboardType;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final TextStyle? style;

  @override
  State<PernanceEditableText> createState() => EditableTextState();
}

class EditableTextState extends State<PernanceEditableText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      textAlign: TextAlign.center,
      cursorColor: Colors.grey,
      cursorWidth: 1, // Adjust this later
      style: widget.style,
      decoration: const InputDecoration(
        border: InputBorder.none,    
        fillColor: Colors.transparent,
        filled: true,
      ),
    );
  }
}