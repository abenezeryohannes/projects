import 'package:flutter/material.dart';

import '../../../../../core/widgets/text.input.form.dart';

class CommentPageBottom extends StatefulWidget {
  const CommentPageBottom(
      {super.key,
      required this.onSend,
      this.controller,
      required this.loading});
  final Future<bool> Function(String x) onSend;
  final TextEditingController? controller;
  final bool loading;
  @override
  State<CommentPageBottom> createState() => _CommentPageBottomState();
}

class _CommentPageBottomState extends State<CommentPageBottom> {
  String text = '';
  TextInputForm? textInputForm;
  final FocusNode _focusNode = FocusNode();
  TextEditingController? controller;
  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textInputForm = initTextForm(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * (9 / 12),
                child: initTextForm(context)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: InkWell(
                onTap: () async {
                  if (!widget.loading) {
                    if (await widget.onSend(controller?.text ?? text)) {
                      textInputForm?.setValue('');
                      controller?.clear();
                      text = '';
                    }
                  }
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                          image:
                              const AssetImage('assets/icon/send-button.png'),
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.secondary,
                              BlendMode.hue))),
                ),
              ))
        ],
      ),
    );
  }

  TextInputForm initTextForm(BuildContext context) {
    return TextInputForm(
      focusNode: _focusNode,
      controller: controller,
      fillColor: Theme.of(context).cardColor,
      placeholder: ('write your comment'),
      maxLines: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      onChanged: (String val) {
        setState(() {
          text = val;
        });
      },
      textInputAction: TextInputAction.go,
      keybardType: TextInputType.text,
      initialValue: text,
      radius: 30,
    );
  }
}
