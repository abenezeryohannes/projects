import 'package:flutter/material.dart';
import 'package:rnginfra/src/core/domain/entities/guest.visitation.entity.dart';

import '../../../../../core/domain/entities/guest.activity.types.dart';
import '../../../../../core/network/api.dart';

class GuestViewActivityPage extends StatefulWidget {
  const GuestViewActivityPage({super.key, required this.activity});
  final GuestVisitationEntity activity;
  @override
  State<GuestViewActivityPage> createState() => _GuestViewActivityPageState();
}

class _GuestViewActivityPageState extends State<GuestViewActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: Colors.transparent,
            child: Container(
                width: MediaQuery.of(context).size.width * (8 / 12),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: _body())));
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          child: _image(),
        ),
        Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 20),
            child: Text(
              widget.activity.guest_type ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            )),
        Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: Text(
              widget.activity.residents ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
        Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: Text(
              widget.activity.short_notes ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            )),
        Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 30, left: 20, right: 20),
            child: Text(
              widget.activity.long_notes ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ))
      ],
    );
  }

  Widget _image() {
    return (widget.activity.guest_image != null &&
            widget.activity.guest_image!.trim().isNotEmpty)
        ? Image.network(
            '${Api.imageUrl()}${widget.activity.guest_image!.replaceFirst('file:///', 'https://')}',
            width: 52,
            height: 52,
          )
        : Container(
            padding: const EdgeInsets.all(5.0),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color(int.parse(GuestActivityTypes.getType(
                                widget.activity?.guest_type ?? '')
                            ?.color ??
                        '0xFF444336'))),
                borderRadius: const BorderRadius.all(Radius.circular(1000))),
            child: Image.asset(
              GuestActivityTypes.getType(widget.activity?.guest_type ?? '')
                      ?.icon ??
                  'assets/img/user_account.png',
              width: 48,
              height: 48,
              color: Color(int.parse(
                  GuestActivityTypes.getType(widget.activity?.guest_type ?? '')
                          ?.color ??
                      '0xFF444336')),
            ),
          );
  }
}
