import 'package:flutter/material.dart';

class EditableText extends StatelessWidget {
  const EditableText({super.key, this.keyboardType = TextInputType.text, this.validator, this.controller});

  final TextInputType keyboardType;
  final FormFieldValidator? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Transaction Name',
        border: InputBorder.none,    
      ),
    );
  }
}