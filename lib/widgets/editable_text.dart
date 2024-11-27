import 'package:flutter/material.dart';

class PernanceEditableText extends StatefulWidget {
  const PernanceEditableText({
    super.key,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.style,
    this.placeholder,
    this.isCurrency = false
  });

  final TextInputType keyboardType;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final TextStyle? style;
  final String? placeholder;
  final bool isCurrency;

  @override
  State<PernanceEditableText> createState() => EditableTextState();
}

class EditableTextState extends State<PernanceEditableText> {
  @override
  Widget build(BuildContext context) {
    return widget.isCurrency ? TextFormField(
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      textAlign: TextAlign.center,
      cursorColor: Colors.grey,
      cursorWidth: 1, // Adjust this later
      style: widget.style,
      decoration: InputDecoration(
        border: InputBorder.none,    
        fillColor: Colors.transparent,
        filled: true,
        hintText: widget.placeholder,
        hintStyle: const TextStyle(color: Colors.black12),
      ),
    ) : TextFormField(
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      textAlign: TextAlign.center,
      cursorColor: Colors.grey,
      cursorWidth: 1, // Adjust this later
      style: widget.style,
      decoration: InputDecoration(
        border: InputBorder.none,    
        fillColor: Colors.transparent,
        filled: true,
        hintText: widget.placeholder,
        hintStyle: const TextStyle(color: Colors.black12),
      ),
    );
  }
}