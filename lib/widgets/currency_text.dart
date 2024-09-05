import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyText extends StatelessWidget {
  const CurrencyText({super.key, required this.amount, this.locale = 'en-US', this.style, this.textAlign});

  final int amount;
  final String? locale;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat.simpleCurrency(locale: locale, decimalDigits: 0);
    return Text(formatter.format(amount), style: style, textAlign: textAlign);
  }
}