import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/core/widgets/big.text.button.dart';
import 'package:linko/src/core/widgets/image.form.dart';
import 'package:linko/src/core/widgets/text.input.form.dart';
import 'package:linko/src/on.business.add.modal.dart';

class AddBusinessPage extends StatefulWidget {
  const AddBusinessPage({super.key});

  @override
  State<AddBusinessPage> createState() => _AddBusinessPageState();
}

class _AddBusinessPageState extends State<AddBusinessPage> {
  late bool check = false;

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
        onDismissed: () {
          Navigator.of(context).maybePop();
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        direction: DismissiblePageDismissDirection.down,
        isFullScreen: true,
        child: Scaffold(
            appBar: _appBar(),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40),
                        child: ImageForm(
                          image: 'https://picsum.photos/200/300',
                          height: 140,
                          radius: 20,
                          width: MediaQuery.of(context).size.width * (12 / 12),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 40),
                        child: TextInputForm(
                            placeholder: 'Business Link',
                            fillColor: Theme.of(context).cardColor,
                            radius: 100,
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 14, bottom: 14, right: 10),
                            onChanged: (val) {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 40),
                        child: TextInputForm(
                            placeholder: 'Business number',
                            fillColor: Theme.of(context).cardColor,
                            radius: 100,
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 14, bottom: 14, right: 10),
                            onChanged: (val) {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 40),
                        child: TextInputForm(
                            placeholder: 'Owner number',
                            fillColor: Theme.of(context).cardColor,
                            radius: 100,
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 14, bottom: 14, right: 10),
                            onChanged: (val) {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 40),
                        child: TextInputForm(
                            placeholder: 'Delivery time',
                            fillColor: Theme.of(context).cardColor,
                            radius: 100,
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 14, bottom: 14, right: 10),
                            onChanged: (val) {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 40),
                        child: TextInputForm(
                            placeholder: 'Delivery fees',
                            fillColor: Theme.of(context).cardColor,
                            radius: 100,
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 14, bottom: 14, right: 10),
                            onChanged: (val) {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 28.0,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                                value: check,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                onChanged: (val) {
                                  setState(() {
                                    check = !check;
                                  });
                                }),
                            Text(
                              'I agree to the Terms & Privacy',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40.0, right: 40, bottom: 20),
                    child: BigTextButton(
                      onClick: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                const OnAddBusinessAddModal());
                      },
                      text: 'Save',
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      cornerRadius: 40,
                    ),
                  )
                ],
              ),
            )));
  }

  AppBar _appBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: RotatedBox(
          quarterTurns: 3,
          child: Icon(
            Icons.chevron_left,
            size: 42,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ),
      title: Text(
        'Add your business',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}
