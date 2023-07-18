import 'package:flutter/material.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/core/widgets/autocomplete.text.form.dart';
import 'package:rnginfra/src/core/widgets/text.input.form.dart';
import 'package:rnginfra/src/guards/activity/presentation/guests/widgets/image.form.dart';

class GuardAddGuestActivity extends StatefulWidget {
  const GuardAddGuestActivity({super.key});

  @override
  State<GuardAddGuestActivity> createState() => _GuardAddGuestActivityState();
}

class _GuardAddGuestActivityState extends State<GuardAddGuestActivity> {
  late UserEntity guest;

  @override
  void initState() {
    guest = UserEntity(name: '', phoneNumber: '', uid: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //image appload;
        ImageForm(
          link: guest.avatar, //'assets/img/person.jpeg',
          radius: 100,
          editing: true,
          onChange: (String? local) async {
            setState(() {
              guest = UserEntity(
                  name: guest.name,
                  phoneNumber: guest.phoneNumber,
                  position: guest.position,
                  avatar: local,
                  uid: '');
            });
          },
        ),
        //add name;
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: TextInputForm(
            radius: 10,
            elevation: 0.5,
            validator: (val) => (val?.length ?? 0) < 4
                ? 'Must be at least 4 characters!'
                : null,
            onChanged: (String val) {},
            placeholder: 'Guest Full Name',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: AutoCompleteTextForm(
            radius: 10,
            elevation: 0.5,
            validator: (val) => (val?.length ?? 0) < 4
                ? 'Must be at least 4 characters!'
                : null,
            onChanged: (String val) {},
            placeholder: 'Validator Staff Member',
            onSelected: (String selected) {},
            suggestions: [],
            suggestionPropertyToShow: '',
          ),
        ),

        //select between options
        //add activator
      ],
    );
  }
}
