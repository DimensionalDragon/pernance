import 'package:flutter/material.dart';
import 'package:pernance/widgets/currency_text.dart';

class PernanceEditableText extends StatefulWidget {
  const PernanceEditableText({
    super.key,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.style,
    this.placeholder,
    this.currencyAmount
  });

  final TextInputType keyboardType;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final TextStyle? style;
  final String? placeholder;
  final int? currencyAmount;

  @override
  State<PernanceEditableText> createState() => EditableTextState();
}

class EditableTextState extends State<PernanceEditableText> {
  @override
  Widget build(BuildContext context) {
    return widget.currencyAmount != null ? CurrencyText(
      amount: widget.currencyAmount!,
      locale: 'id-ID',
      style: widget.style,
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