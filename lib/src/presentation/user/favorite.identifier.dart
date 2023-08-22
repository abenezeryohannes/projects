import 'package:flutter/material.dart';
import 'package:linko/src/domain/user/entities/favorites.entity.dart';

class FavoriteIdentifier extends StatefulWidget {
  const FavoriteIdentifier(
      {super.key,
      this.fav,
      this.padding = 8,
      this.size = 20,
      this.text,
      required this.onClick});
  final FavoriteEntity? fav;
  final Function onClick;
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
          child: InkWell(
            onTap: () {
              widget.onClick();
            },
            child: Icon(
              widget.fav == null ? Icons.favorite_outline : Icons.favorite,
              size: widget.size,
              color: Theme.of(context).colorScheme.secondary,
            ),
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
