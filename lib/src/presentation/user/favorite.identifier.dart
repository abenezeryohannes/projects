import 'package:flutter/material.dart';

class FavoriteIdentifier extends StatefulWidget {
  const FavoriteIdentifier(
      {super.key,
      required this.isTrue,
      this.padding = 8,
      this.size = 20,
      this.text});
  final bool isTrue;
  final double padding;
  final double size;
  final String? text;
  @override
  State<FavoriteIdentifier> createState() => _FavoriteIdentifierState();
}

class _FavoriteIdentifierState extends State<FavoriteIdentifier> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          padding: EdgeInsets.all(widget.padding),
          child: Icon(
            widget.isTrue ? Icons.favorite : Icons.favorite_outline,
            size: widget.size,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.text ?? '',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.background),
        )
      ],
    );
  }
}
