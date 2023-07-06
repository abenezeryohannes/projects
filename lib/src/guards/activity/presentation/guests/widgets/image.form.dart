import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rnginfra/src/core/widgets/custom.shimmer.dart';

class ImageForm extends StatefulWidget {
  const ImageForm(
      {super.key,
      this.link,
      this.local,
      this.radius = 20,
      this.border,
      this.loading = false,
      this.height = 100,
      this.width = 100,
      this.editing = false,
      this.delete = false,
      required this.onChange});
  final String? link;
  final String? local;
  final BoxBorder? border;
  final double radius;
  final bool loading;
  final double height;
  final double width;
  final bool editing;
  final bool delete;
  final Function(String? local) onChange;
  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      show: _loading || widget.loading,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          border: widget.border,
          image: DecorationImage(
              image: cover(widget.local ?? widget.link),
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(Colors.grey.shade700, BlendMode.overlay)),
        ),
        alignment: Alignment.center,
        height: widget.height,
        width: widget.height,
        child: body(),
      ),
    );
  }

  ImageProvider<Object> cover(String? link) {
    if (link == null) {
      return const AssetImage('assets/img/placeholder.png');
    } else if (link.startsWith('http')) {
      return NetworkImage(link);
    } else if (link.startsWith('asset')) {
      return AssetImage(link);
    } else {
      return FileImage(File.fromUri(Uri.parse(link)));
    }
  }

  Widget body() {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.editing)
            IconButton(
              onPressed: () {
                onEdit(context);
              },
              icon: Icon(
                (widget.link == null && widget.local == null)
                    ? Icons.add
                    : Icons.edit,
                color: Colors.white,
                size: widget.height / 3,
              ),
            ),
          if (widget.delete &&
              widget.editing &&
              (widget.link != null || widget.local != null))
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
                size: widget.height / 3,
              ),
              onPressed: () {
                onDelete(context);
              },
            ),
        ],
      ),
    );
  }

  Future onDelete(BuildContext context) async {
    return await widget.onChange(null);
  }

  Future onEdit(BuildContext context) async {
    File image;
    var imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _loading = true;
    });
    if (imagePicker != null) {
      image = File(imagePicker.path);
      if (await image.exists()) await widget.onChange(imagePicker.path);
    }
    setState(() {
      _loading = false;
    });
  }
}
