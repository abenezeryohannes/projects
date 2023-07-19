import 'package:flutter/material.dart';
import 'core/widgets/big.text.button.dart';

class OnAddBusinessAddModal extends StatefulWidget {
  const OnAddBusinessAddModal({super.key});

  @override
  State<OnAddBusinessAddModal> createState() => _OnAddBusinessAddModalState();
}

class _OnAddBusinessAddModalState extends State<OnAddBusinessAddModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icon/business_add.png',
                      width: 110,
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Done!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 60.0, left: 30, right: 30),
                    child: Text(
                      'Our team now is working to add your business link with other businesses, come back soon and you will find your business onlne!',
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30, bottom: 20),
                child: BigTextButton(
                  onClick: () {
                    Navigator.of(context).maybePop();
                  },
                  text: 'Home',
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  cornerRadius: 40,
                ),
              )
            ]),
      ),
    );
  }
}
