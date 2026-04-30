import 'package:flutter/material.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';
import 'package:poketter/core/components/molecules/form/molecule_text_field.dart';

class MoleculeSearch extends StatelessWidget {
  const MoleculeSearch({
    super.key,
    this.textFieldKey,
    this.hintText,
    this.readOnly = false,
    this.onTap,
    this.isDense = false,
    this.onChanged,
  });

  final GlobalKey<MoleculeTextFieldState>? textFieldKey;
  final String? hintText;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool isDense;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return MoleculeTextField(
      key: textFieldKey,
      readOnly: readOnly,
      onTap: onTap,
      isDense: isDense,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search, color: context.color.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: context.color.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: context.color.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: context.color.error, width: 2),
        ),
      ),
    );
  }
}
