import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rnginfra/src/core/widgets/big.text.button.dart';

import '../errors/failure.dart';

enum ErrorShowType { Horizontal, Vertical, TextOnly }

class ShowError extends StatefulWidget {
  const ShowError(
      {Key? key,
      required this.failure,
      this.ErrorShowType,
      this.onRetry,
      this.height = 800})
      : super(key: key);
  final Failure failure;
  final Function? onRetry;
  final double? height;
  final ErrorShowType;

  @override
  State<ShowError> createState() => _ShowErrorState();
}

class _ShowErrorState extends State<ShowError> {
  @override
  Widget build(BuildContext context) {
    switch (widget.ErrorShowType) {
      case ErrorShowType.TextOnly:
        return Center(child: _text());
      case ErrorShowType.Horizontal:
        return Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _img(),
            const SizedBox(height: 40),
            Flexible(child: _text())
          ],
        ));
      default:
        return SizedBox(
          height: widget.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _img(),
              const SizedBox(height: 40),
              Flexible(child: _text())
            ],
          ),
        );
    }
  }

  Widget _img() {
    if (widget.failure.runtimeType == CacheFailure ||
        widget.failure.runtimeType == NetworkFailure) {
      return Image.asset(
        "assets/icon/no_connection.png",
        height: (widget.ErrorShowType == ErrorShowType.Horizontal) ? 50 : 100,
      );
    }
    if (widget.failure.runtimeType == NoDataFailure) {
      return Image.asset(
        "assets/icon/empty.png",
        height: (widget.ErrorShowType == ErrorShowType.Horizontal) ? 50 : 100,
      );
    } else {
      return Image.asset(
        "assets/icon/error.png",
        height: (widget.ErrorShowType == ErrorShowType.Horizontal) ? 50 : 100,
      );
    }
  }

  Widget _text() {
    if (widget.failure.runtimeType == NoDataFailure) {
      return Column(
        children: [
          Text(
            widget.failure.message ?? "Soryy, No data here yet!!",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(widget.failure.message ?? "Something Went Wrong!!",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
          if (widget.onRetry != null)
            BigTextButton(
              onClick: () {
                widget.onRetry!();
              },
              text: 'Retry',
              cornerRadius: 20,
              backgroudColor: Theme.of(context).colorScheme.background,
              textColor: Theme.of(context).colorScheme.secondary,
              borderColor: Theme.of(context).colorScheme.secondary,
              borderWidth: 2,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
              horizontalMargin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * (3 / 12),
                  vertical: 16),
            )
        ],
      );
    }
  }
}
