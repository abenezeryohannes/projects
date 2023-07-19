import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linko/src/core/widgets/custom.shimmer.dart';

class ImageForm extends StatefulWidget {
  const ImageForm(
      {super.key,
      this.backgroundColor,
      this.radius,
      this.boxShadow,
      this.width,
      this.image,
      this.height,
      this.fit});

  final Color? backgroundColor;
  final double? radius;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;
  final String? image;
  final BoxFit? fit;
  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 200,
      width: widget.width ?? 200,
      decoration: BoxDecoration(
          boxShadow: widget.boxShadow,
          color: widget.backgroundColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 0))),
      child: widget.image != null ? _getImage(context, widget.image!) : null,
    );
  }

  Widget _getImage(BuildContext context, String url) {
    if (url.contains('http')) {
      return Image.network(
        url,
        width: widget.width,
        height: widget.height,
        loadingBuilder: (context, child, loadingProgress) =>
            _loading(loadingProgress),
        errorBuilder: (context, error, stackTrace) => _error(error),
      );
    } else if (url.contains('assets')) {
      return Image.asset(
        url,
        width: widget.width,
        height: widget.height,
        errorBuilder: (context, error, stackTrace) => _error(error),
      );
    } else if (url.contains('file')) {
      return Image.file(
        File(url),
        width: widget.width,
        height: widget.height,
        errorBuilder: (context, error, stackTrace) => _error(error),
      );
    } else {
      return Image.asset(
        'assets/icon/error.png',
        width: widget.width,
        height: widget.height,
        errorBuilder: (context, error, stackTrace) => _error(error),
      );
    }
  }

  Widget _loading(ImageChunkEvent? _) {
    return CustomShimmer(
      show: true,
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).disabledColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.radius ?? 0))),
          width: widget.width,
          height: widget.height),
    );
  }

  Widget _error(Object? error) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 0))),
      width: widget.width,
      height: widget.height,
      child: Icon(
        Icons.error,
        size: (widget.height ?? 200) / 4,
      ),
    );
  }
}
