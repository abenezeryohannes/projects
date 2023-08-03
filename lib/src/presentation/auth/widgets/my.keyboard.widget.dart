import 'package:flutter/material.dart';

class MyKeboard extends StatefulWidget {
  const MyKeboard({super.key, required this.onKeyDown, required this.fontSize});
  final double fontSize;
  final void Function(String char) onKeyDown;
  @override
  State<MyKeboard> createState() => My_KeboardState();
}

class My_KeboardState extends State<MyKeboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    widget.onKeyDown("1");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "1",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    widget.onKeyDown("2");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "2",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    widget.onKeyDown("3");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "3",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    widget.onKeyDown("4");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "4",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    widget.onKeyDown("5");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "5",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    widget.onKeyDown("6");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "6",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    widget.onKeyDown("7");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "7",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    widget.onKeyDown("8");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "8",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    widget.onKeyDown("9");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "9",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "   ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    widget.onKeyDown("0");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Text(
                      "0",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontSize: widget.fontSize),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    widget.onKeyDown("back");
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Icon(
                      Icons.backspace_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
