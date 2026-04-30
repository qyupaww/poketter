import 'package:flutter/material.dart';

class AtomCircularLoading extends StatelessWidget {
  const AtomCircularLoading({
    super.key,
    required this.size,
    required this.color,
    this.strokeWidth = 3,
  });

  final double size;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2.0),
      child: CircularProgressIndicator(color: color, strokeWidth: strokeWidth),
    );
  }
}
