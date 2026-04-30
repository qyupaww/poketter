import 'package:flutter/material.dart';
import 'package:poketter/core/assets/src/morpheme_illustrations.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/components/atoms/atom_button.dart';
import 'package:poketter/core/components/atoms/atom_image.dart';
import 'package:poketter/core/components/atoms/atom_spacing.dart';
import 'package:poketter/core/extensions/localization_extension.dart';

/// A widget that displays an empty state with optional image, text, and button.
///
/// This widget is useful for showing a message when there is no data to display.
/// It can optionally include an image and a button for user interaction.
class MoleculeEmptyState extends StatelessWidget {
  /// Creates a [MoleculeEmptyState] widget with optional image, text, and description.
  ///
  /// The [padding] parameter allows customization of the padding around the content.
  /// If [textButton], [onButtonPressed], and [iconButton] are not provided, the button will not be displayed.
  const MoleculeEmptyState({
    super.key,
    this.image,
    this.text,
    this.description,
    this.iconSizes,
    this.padding = const EdgeInsets.all(ConstantSizes.s16),
  }) : textButton = null,
       onButtonPressed = null,
       iconButton = null;

  /// Creates a [MoleculeEmptyState] widget with a button.
  ///
  /// This constructor allows you to specify a button with [textButton], [onButtonPressed], and [iconButton].
  const MoleculeEmptyState.button({
    super.key,
    this.image,
    this.text,
    this.description,
    this.padding = const EdgeInsets.all(ConstantSizes.s16),
    this.textButton,
    this.onButtonPressed,
    this.iconButton,
    this.iconSizes,
  });

  /// The path to the image asset to display.
  final String? image;

  /// The main text to display in the empty state.
  final String? text;

  /// The description text to provide additional context.
  final String? description;

  /// The padding around the content of the empty state.
  final EdgeInsetsGeometry padding;

  /// The text to display on the button.
  final String? textButton;

  /// The callback function to execute when the button is pressed.
  final Function()? onButtonPressed;

  /// The icon to display on the button.
  final Widget? iconButton;

  /// size for icon
  final double? iconSizes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AtomImage.asset(
            image ?? MorphemeIllustrations.emptyState,
            width: iconSizes ?? 100,
            height: iconSizes ?? 100,
            fit: BoxFit.contain,
          ),
          const AtomSpacing.vertical16(),
          Text(
            text ?? context.s.emptyStateTitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const AtomSpacing.vertical4(),
          Text(
            description ?? context.s.emptyStateDescription,
            textAlign: TextAlign.center,
          ),
          if (onButtonPressed != null) ...[
            const AtomSpacing.vertical16(),
            AtomButton.elevated(
              icon: iconButton,
              text: textButton ?? context.s.oke,
              onPressed: onButtonPressed,
            ),
          ],
        ],
      ),
    );
  }
}
