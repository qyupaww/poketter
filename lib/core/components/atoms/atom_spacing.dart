import 'package:flutter/material.dart';

class AtomSpacing extends StatelessWidget {
  const AtomSpacing.vertical({super.key, required this.size})
    : axis = Axis.vertical;
  const AtomSpacing.vertical2({super.key}) : size = 2, axis = Axis.vertical;
  const AtomSpacing.vertical4({super.key}) : size = 4, axis = Axis.vertical;
  const AtomSpacing.vertical8({super.key}) : size = 8, axis = Axis.vertical;
  const AtomSpacing.vertical12({super.key}) : size = 12, axis = Axis.vertical;
  const AtomSpacing.vertical16({super.key}) : size = 16, axis = Axis.vertical;
  const AtomSpacing.vertical20({super.key}) : size = 20, axis = Axis.vertical;
  const AtomSpacing.vertical24({super.key}) : size = 24, axis = Axis.vertical;
  const AtomSpacing.vertical28({super.key}) : size = 28, axis = Axis.vertical;
  const AtomSpacing.vertical32({super.key}) : size = 32, axis = Axis.vertical;
  const AtomSpacing.vertical36({super.key}) : size = 36, axis = Axis.vertical;
  const AtomSpacing.vertical40({super.key}) : size = 40, axis = Axis.vertical;
  const AtomSpacing.vertical44({super.key}) : size = 44, axis = Axis.vertical;
  const AtomSpacing.vertical48({super.key}) : size = 48, axis = Axis.vertical;
  const AtomSpacing.vertical52({super.key}) : size = 52, axis = Axis.vertical;
  const AtomSpacing.vertical56({super.key}) : size = 56, axis = Axis.vertical;
  const AtomSpacing.vertical60({super.key}) : size = 60, axis = Axis.vertical;
  const AtomSpacing.vertical64({super.key}) : size = 64, axis = Axis.vertical;
  const AtomSpacing.vertical68({super.key}) : size = 68, axis = Axis.vertical;
  const AtomSpacing.vertical72({super.key}) : size = 72, axis = Axis.vertical;
  const AtomSpacing.vertical76({super.key}) : size = 76, axis = Axis.vertical;
  const AtomSpacing.vertical80({super.key}) : size = 80, axis = Axis.vertical;

  const AtomSpacing.horizontal({super.key, required this.size})
    : axis = Axis.horizontal;
  const AtomSpacing.horizontal2({super.key}) : size = 2, axis = Axis.horizontal;
  const AtomSpacing.horizontal4({super.key}) : size = 4, axis = Axis.horizontal;
  const AtomSpacing.horizontal8({super.key}) : size = 8, axis = Axis.horizontal;
  const AtomSpacing.horizontal12({super.key})
    : size = 12,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal16({super.key})
    : size = 16,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal20({super.key})
    : size = 20,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal24({super.key})
    : size = 24,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal28({super.key})
    : size = 28,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal32({super.key})
    : size = 32,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal36({super.key})
    : size = 36,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal40({super.key})
    : size = 40,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal44({super.key})
    : size = 44,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal48({super.key})
    : size = 48,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal52({super.key})
    : size = 52,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal56({super.key})
    : size = 56,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal60({super.key})
    : size = 60,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal64({super.key})
    : size = 64,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal68({super.key})
    : size = 68,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal72({super.key})
    : size = 72,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal76({super.key})
    : size = 76,
      axis = Axis.horizontal;
  const AtomSpacing.horizontal80({super.key})
    : size = 80,
      axis = Axis.horizontal;

  final double size;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return axis == Axis.horizontal
        ? SizedBox(width: size)
        : SizedBox(height: size);
  }
}
