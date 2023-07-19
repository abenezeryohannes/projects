import 'package:flutter/material.dart';
import 'package:linko/src/core/widgets/big.text.button.dart';
import 'package:linko/src/favorite.identifier.dart';

import 'core/widgets/text.badge.dart';

class BusinessCard extends StatefulWidget {
  const BusinessCard({super.key});

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: const Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FavoriteIdentifier(isTrue: true, text: '(32)'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 5, right: 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'PICK',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const TextBadge(
                            color: Colors.blueAccent, text: 'CHEF PICK')
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        _items(text: '25 Min', icon: 'erase.png'),
                        const SizedBox(
                          width: 10,
                        ),
                        _items(text: 'Free', icon: 'erase.png'),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 100,
                  child: BigTextButton(
                    onClick: () {},
                    text: 'CALL',
                    textColor: Theme.of(context).colorScheme.onBackground,
                    borderColor: Theme.of(context).colorScheme.secondary,
                    borderWidth: 1,
                    fontWight: FontWeight.w600,
                    cornerRadius: 8,
                    backgroudColor: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _items({required String text, required String icon}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icon/$icon',
          width: 16,
          height: 16,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
