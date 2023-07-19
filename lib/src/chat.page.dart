import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/add.business.page.dart';
import 'package:linko/src/chat.more.bottom.sheet.dart';
import 'package:linko/src/core/widgets/text.input.form.dart';
import 'package:linko/src/lilnko.anime.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: _topAppBar(),
            ),
            const Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 100.0),
                    child: LinkoAnime(),
                  )
                ],
              ),
            ),
            Align(alignment: Alignment.bottomCenter, child: _bottomTxt())
          ],
        ),
      ),
    );
  }

  Widget _topAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10, right: 20, bottom: 10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 10, right: 20, bottom: 10),
            child: Material(
                color: Theme.of(context).cardColor,
                elevation: 1,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => const ChatMoreBottomSheet());
                    },
                    icon: Icon(
                      Icons.more_horiz,
                      size: 32,
                      color: Theme.of(context).disabledColor,
                    )))),
      ],
    );
  }

  Widget _bottomTxt() {
    return Material(
      color: Theme.of(context).cardColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * (9 / 12),
              child: TextInputForm(
                fillColor: Theme.of(context).disabledColor,
                placeholder: 'Message',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                onChanged: (String val) {},
                radius: 30,
                suffixIcon: const Icon(
                  Icons.graphic_eq,
                ),
              ),
            ),
          ),
          Material(
              color: Theme.of(context).colorScheme.secondary,
              elevation: 1,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: IconButton(
                  onPressed: () {
                    context.pushTransparentRoute(const AddBusinessPage());
                  },
                  icon: Transform.rotate(
                    angle: -.50,
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  )))
        ],
      ),
    );
  }
}
