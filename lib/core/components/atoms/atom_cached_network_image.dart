import 'package:flutter/material.dart';
import 'package:morpheme_cached_network_image/morpheme_cached_network_image.dart';
import 'package:poketter/core/assets/src/morpheme_illustrations.dart';
import 'package:poketter/core/components/atoms/atom_image.dart';

class AtomCachedNetworkImage extends StatelessWidget {
  const AtomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return MorphemeCachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height,
          child: AtomImage.asset(
            MorphemeIllustrations.placeholder,
            width: width,
            height: height,
            fit: fit,
          ),
        );
      },
    );
  }
}
