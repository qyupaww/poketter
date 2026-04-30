import 'package:flutter/material.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';
import 'package:poketter/core/components/atoms/atom_circular_loading.dart';
import 'package:poketter/core/components/atoms/atom_text_scale_down.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum _TypeButton { elevated, outlined, text }

class AtomButton extends StatelessWidget {
  const AtomButton.elevated({
    this.text,
    required this.onPressed,
    super.key,
    this.isExpand = true,
    this.style,
    this.textStyle,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.isLoading = false,
    this.isDisabled = false,
    this.height = ConstantSizes.heightButton,
    this.textRich = const [],
  }) : assert(text != null || textRich.length > 0),
       _type = _TypeButton.elevated;

  const AtomButton.outlined({
    this.text,
    required this.onPressed,
    super.key,
    this.isExpand = true,
    this.style,
    this.textStyle,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.isLoading = false,
    this.isDisabled = false,
    this.height = ConstantSizes.heightButton,
    this.textRich = const [],
  }) : assert(text != null || textRich.length > 0),
       _type = _TypeButton.outlined;

  const AtomButton.text({
    this.text,
    required this.onPressed,
    super.key,
    this.isExpand = true,
    this.style,
    this.textStyle,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.isLoading = false,
    this.isDisabled = false,
    this.height = ConstantSizes.heightButton,
    this.textRich = const [],
  }) : assert(text != null || textRich.length > 0),
       _type = _TypeButton.text;

  final _TypeButton _type;
  final GestureTapCallback? onPressed;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final String? text;
  final List<TextSpan> textRich;
  final Widget? icon;
  final IconAlignment iconAlignment;
  final bool isExpand;
  final bool isLoading;
  final bool isDisabled;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: SizedBox(
        width: isExpand ? double.infinity : null,
        height: height,
        child: Builder(
          builder: (context) {
            switch (_type) {
              case _TypeButton.elevated:
                if (icon != null) {
                  return ElevatedButton.icon(
                    onPressed: isLoading || isDisabled ? null : onPressed,
                    style: style,
                    iconAlignment: iconAlignment,
                    label: isLoading
                        ? const SizedBox()
                        : text != null
                        ? AtomTextScaleDown(text ?? '', style: textStyle)
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text.rich(
                              TextSpan(children: textRich),
                              style: textStyle,
                            ),
                          ),
                    icon: isLoading
                        ? AtomCircularLoading(
                            size: 24,
                            color: context.color.primary,
                          )
                        : icon!,
                  );
                }
                return ElevatedButton(
                  onPressed: isLoading || isDisabled ? null : onPressed,
                  style: style,
                  child: isLoading
                      ? AtomCircularLoading(
                          size: 24,
                          color: context.color.primary,
                        )
                      : text != null
                      ? AtomTextScaleDown(text ?? '', style: textStyle)
                      : FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text.rich(
                            TextSpan(children: textRich),
                            style: textStyle,
                          ),
                        ),
                );
              case _TypeButton.outlined:
                if (icon != null) {
                  return OutlinedButton.icon(
                    onPressed: isLoading || isDisabled ? null : onPressed,
                    style: style,
                    iconAlignment: iconAlignment,
                    label: isLoading
                        ? const SizedBox()
                        : text != null
                        ? AtomTextScaleDown(text ?? '', style: textStyle)
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text.rich(
                              TextSpan(children: textRich),
                              style: textStyle,
                            ),
                          ),
                    icon: isLoading
                        ? AtomCircularLoading(
                            size: 24,
                            color: context.color.primary,
                          )
                        : icon!,
                  );
                }
                return OutlinedButton(
                  onPressed: isLoading || isDisabled ? null : onPressed,
                  style: style,
                  child: isLoading
                      ? AtomCircularLoading(
                          size: 24,
                          color: context.color.primary,
                        )
                      : text != null
                      ? AtomTextScaleDown(text ?? '', style: textStyle)
                      : FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text.rich(
                            TextSpan(children: textRich),
                            style: textStyle,
                          ),
                        ),
                );
              default:
                if (icon != null) {
                  return TextButton.icon(
                    onPressed: isLoading || isDisabled ? null : onPressed,
                    style: style,
                    iconAlignment: iconAlignment,
                    label: isLoading
                        ? const SizedBox()
                        : text != null
                        ? AtomTextScaleDown(text ?? '', style: textStyle)
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text.rich(
                              TextSpan(children: textRich),
                              style: textStyle,
                            ),
                          ),
                    icon: isLoading
                        ? AtomCircularLoading(
                            size: 24,
                            color: context.color.primary,
                          )
                        : icon!,
                  );
                }
                return TextButton(
                  onPressed: isLoading || isDisabled ? null : onPressed,
                  style: style,
                  child: isLoading
                      ? AtomCircularLoading(
                          size: 24,
                          color: context.color.primary,
                        )
                      : text != null
                      ? AtomTextScaleDown(text ?? '', style: textStyle)
                      : FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text.rich(
                            TextSpan(children: textRich),
                            style: textStyle,
                          ),
                        ),
                );
            }
          },
        ),
      ),
    );
  }
}
