import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AtomImage extends StatelessWidget {
  const AtomImage.asset(
    this.image, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.blendMode,
    this.colorFilter,
    this.showDetailImage = false,
  }) : file = null,
       imageUrl = '';

  const AtomImage.network(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.blendMode,
    this.colorFilter,
    this.showDetailImage = false,
  }) : file = null,
       image = '';

  const AtomImage.file(
    File this.file, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.blendMode,
    this.colorFilter,
    this.showDetailImage = false,
  }) : image = '',
       imageUrl = '';

  final String image;

  final String imageUrl;

  final double? width;

  final double? height;

  final BoxFit? fit;

  final Color? color;

  final BlendMode? blendMode;

  final ColorFilter? colorFilter;

  final File? file;

  final bool showDetailImage;

  Future<void> pushShowDetailImage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(),
          body: Center(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 10,
              child: _BuildImage(
                image: image,
                imageUrl: imageUrl,
                file: file,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.contain,
                color: color,
                blendMode: blendMode,
                colorFilter: colorFilter,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buildImage = _BuildImage(
      image: image,
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      color: color,
      blendMode: blendMode,
      colorFilter: colorFilter,
      file: file,
    );

    if (showDetailImage) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => pushShowDetailImage(context),
        child: buildImage,
      );
    }
    return buildImage;
  }
}

class _BuildImage extends StatelessWidget {
  const _BuildImage({
    required this.image,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.blendMode,
    this.colorFilter,
    this.file,
  });

  final String image;
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? blendMode;
  final ColorFilter? colorFilter;
  final File? file;

  int? cacheSize(BuildContext context, num size) {
    if (size == double.infinity) return null;
    return (size * MediaQuery.of(context).devicePixelRatio).round();
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNotEmpty &&
        RegExp(r'^(http|https):\/\/.+\.svg').hasMatch(imageUrl)) {
      return Skeleton.shade(
        child: SvgPicture.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          colorFilter:
              colorFilter ??
              (color != null
                  ? ColorFilter.mode(color!, blendMode ?? BlendMode.srcIn)
                  : null),
        ),
      );
    }

    if (image.isNotEmpty && RegExp(r'.svg').hasMatch(image)) {
      return Skeleton.shade(
        child: SvgPicture.asset(
          image,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          colorFilter:
              colorFilter ??
              (color != null
                  ? ColorFilter.mode(color!, blendMode ?? BlendMode.srcIn)
                  : null),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          int? cacheWidth = cacheSize(context, constraints.maxWidth) ?? 0;
          int? cacheHeight = cacheSize(context, constraints.maxHeight) ?? 0;

          final aspectRatio = cacheWidth / cacheHeight;

          if (aspectRatio > 0) {
            cacheWidth = null;
          } else {
            cacheHeight = null;
          }

          if (cacheWidth == 0) cacheWidth = null;
          if (cacheHeight == 0) cacheHeight = null;

          if (file != null) {
            return Image.file(
              file!,
              width: width,
              height: height,
              fit: fit,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
              color: color,
              colorBlendMode: blendMode,
            );
          }

          if (imageUrl.isNotEmpty) {
            return Image.network(
              imageUrl,
              width: width,
              height: height,
              fit: fit,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
              color: color,
              colorBlendMode: blendMode,
            );
          }

          return Image.asset(
            image,
            width: width,
            height: height,
            fit: fit,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            color: color,
            colorBlendMode: blendMode,
          );
        },
      ),
    );
  }
}
