import 'package:flutter/material.dart';

class AtomSliverSpacing extends StatelessWidget {
  const AtomSliverSpacing.vertical({super.key, required this.size})
    : axis = Axis.vertical;
  const AtomSliverSpacing.vertical4({super.key})
    : size = 4,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical8({super.key})
    : size = 8,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical12({super.key})
    : size = 12,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical16({super.key})
    : size = 16,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical20({super.key})
    : size = 20,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical24({super.key})
    : size = 24,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical28({super.key})
    : size = 28,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical32({super.key})
    : size = 32,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical36({super.key})
    : size = 36,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical40({super.key})
    : size = 40,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical44({super.key})
    : size = 44,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical48({super.key})
    : size = 48,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical52({super.key})
    : size = 52,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical56({super.key})
    : size = 56,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical60({super.key})
    : size = 60,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical64({super.key})
    : size = 64,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical68({super.key})
    : size = 68,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical72({super.key})
    : size = 72,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical76({super.key})
    : size = 76,
      axis = Axis.vertical;
  const AtomSliverSpacing.vertical80({super.key})
    : size = 80,
      axis = Axis.vertical;

  const AtomSliverSpacing.horizontal({super.key, required this.size})
    : axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal4({super.key})
    : size = 4,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal8({super.key})
    : size = 8,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal12({super.key})
    : size = 12,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal16({super.key})
    : size = 16,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal20({super.key})
    : size = 20,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal24({super.key})
    : size = 24,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal28({super.key})
    : size = 28,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal32({super.key})
    : size = 32,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal36({super.key})
    : size = 36,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal40({super.key})
    : size = 40,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal44({super.key})
    : size = 44,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal48({super.key})
    : size = 48,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal52({super.key})
    : size = 52,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal56({super.key})
    : size = 56,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal60({super.key})
    : size = 60,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal64({super.key})
    : size = 64,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal68({super.key})
    : size = 68,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal72({super.key})
    : size = 72,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal76({super.key})
    : size = 76,
      axis = Axis.horizontal;
  const AtomSliverSpacing.horizontal80({super.key})
    : size = 80,
      axis = Axis.horizontal;

  final double size;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return axis == Axis.horizontal
        ? SliverToBoxAdapter(child: SizedBox(width: size))
        : SliverToBoxAdapter(child: SizedBox(height: size));
  }
}
