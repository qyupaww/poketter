import 'package:flutter/material.dart';

class AtomText extends StatelessWidget {
  const AtomText.heading1(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.color,
    this.fontWeight,
  }) : _style = const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  const AtomText.heading2(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.color,
    this.fontWeight,
  }) : _style = const TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  const AtomText.bodyLarge(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.color,
    this.fontWeight,
  }) : _style = const TextStyle(fontSize: 16);
  const AtomText.bodyLargeSemiBold(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.color,
    this.fontWeight,
  }) : _style = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  const AtomText.bodyMedium(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.color,
    this.fontWeight,
  }) : _style = const TextStyle(fontSize: 14);
  const AtomText.bodyMediumBold(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.color,
    this.fontWeight,
  }) : _style = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  const AtomText.bodySmall(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.color,
    this.fontWeight,
  }) : _style = const TextStyle(fontSize: 12);
  const AtomText.bodySmallBold(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.color,
    this.fontWeight,
  }) : _style = const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

  final String text;
  final TextStyle? style;
  final TextStyle _style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _style.copyWith(color: color, fontWeight: fontWeight).merge(style),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
