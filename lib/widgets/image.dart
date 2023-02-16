import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tunzaa_test/extensions/context_extension.dart';

class AppImage extends StatelessWidget {
  final String image;
  final double? height, width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  
  const AppImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (borderRadius == null) return buildImage();
    return ClipRRect(
      borderRadius: borderRadius,
      child: buildImage(),
    );
  }

  buildImage() {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) {
        return Container(
          height: height,
          width: width,
          color: context.colorScheme.primary,
          child: Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: context.colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
