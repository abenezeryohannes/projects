import 'package:flutter/material.dart';

import '../../../../../core/widgets/image.form.dart';

class AddImagesForm extends StatefulWidget {
  const AddImagesForm(
      {Key? key,
      required this.bulkImages,
      required this.uploadImage,
      required this.onLoadingChanged,
      this.validator,
      required this.placeholder})
      : super(key: key);
  final List<BulkImageDto> bulkImages;
  final String? Function()? validator;
  final Function(String imgPath) uploadImage;
  final Function(bool isLoading) onLoadingChanged;
  final String placeholder;
  @override
  State<AddImagesForm> createState() => _AddImagesFormState();
}

class BulkImageDto {
  String? img;
  String? localImg;
  BulkImageDto({this.img, this.localImg});
}

class _AddImagesFormState extends State<AddImagesForm> {
  @override
  Widget build(BuildContext context) {
    return Wrap(runSpacing: 10, spacing: 2, children: getForms());
  }

  List<Widget> getForms() {
    String? error = widget.validator == null ? null : widget.validator!();
    List<Widget> res = widget.bulkImages
        .map((pI) => Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ImageForm(
                localImage: pI.localImg,
                image: pI.img,
                width: 60,
                height: 60,
                radius: 12,
                placeholder: Image.asset(
                  widget.placeholder,
                  height: 60,
                  fit: BoxFit.cover,
                  // color:
                  //     Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                ),
                onUpload: (imagePath) {
                  widget.uploadImage(imagePath);
                },
                isLoading: (loading) {
                  widget.onLoadingChanged(loading);
                },
              ),
            ))
        .toList();
    res.add(Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ImageForm(
        backgroundColor: Colors.grey.shade100,
        radius: 12,
        width: 60,
        height: 60,
        placeholder: Image.asset(
          widget.placeholder,
          height: error == null ? 60 : 60,
          fit: BoxFit.cover,

          // color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        ),
        onUpload: (imagePath) {
          widget.uploadImage(imagePath);
        },
        isLoading: (loading) {
          widget.onLoadingChanged(loading);
        },
      ),
    ));
    return res;
  }
}
