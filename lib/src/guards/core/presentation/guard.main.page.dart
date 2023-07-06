import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:rnginfra/src/core/animations/fade.animation.dart';
import 'package:rnginfra/src/core/animations/position.animation.dart';
import 'package:rnginfra/src/guards/activity/presentation/guests/pages/guard.guest.activity.page.dart';
import 'package:rnginfra/src/guards/activity/presentation/new_activity/pages/add.activity.page.dart';
import 'package:rnginfra/src/guards/patroll/presentation/patrolls_list/pages/guard.patroll.page.dart';
import 'package:rnginfra/src/guards/activity/presentation/staffs/pages/guard.staff.activity.page.dart';

import '../../../core/animations/animate.dart';

class GuardMainPage extends StatefulWidget {
  const GuardMainPage({super.key});

  @override
  State<GuardMainPage> createState() => _GuardMainPageState();
}

class _GuardMainPageState extends State<GuardMainPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();

  int _currentIndex = 0;
  List<IconData> iconList = [
    Icons.local_activity,
    Icons.new_label,
    Icons.security
  ];
  late StreamController<Animate> controller;
  late AnimationController _animationIconController;
  late bool fabsVisible = false;
  @override
  void initState() {
    fabsVisible = false;
    controller = StreamController.broadcast();

    _animationIconController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(F.title),
      // ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          _body(_currentIndex),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeAnimation(
                  begin: const Offset(0, 2),
                  controller: controller,
                  delay: 100,
                  end: const Offset(0, 0),
                  milli: 600,
                  finish: 1,
                  start: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0, bottom: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeAnimation(
                          begin: const Offset(0, 0),
                          controller: controller,
                          delay: 100,
                          end: const Offset(0, 0),
                          milli: 600,
                          finish: 1,
                          start: 0,
                          child: Material(
                            elevation: 1,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddActivityPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  'Add Patroll',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddActivityPage()));
                          },
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PositionAnimation(
                  begin: const Offset(1, 2),
                  controller: controller,
                  delay: 100,
                  end: const Offset(0, 0),
                  milli: 600,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          elevation: 1,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddActivityPage()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                'Add Activity',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(right: 16.0, bottom: 8),
                            child: FloatingActionButton(
                                heroTag: 'ADD_ACTIVITY',
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddActivityPage()));
                                },
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                child: Icon(
                                  Icons.add,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ))
                            // FloatingActionButton(
                            //   onPressed: () {},
                            //   child: Icon(
                            //     Icons.add,
                            //     color: Theme.of(context).colorScheme.onSecondary,
                            //   ),
                            // ),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: AnimatedFloatingActionButton(
      //   key: key,
      //   fabButtons: <Widget>[
      //     add(),
      //     image(),
      //     inbox(),
      //   ],
      //   colorStartAnimation: Colors.blue,
      //   colorEndAnimation: Colors.red,
      //   animatedIconData: AnimatedIcons.menu_close,
      // ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          if (!fabsVisible) {
            controller.sink.add(Animate.forward);
            setState(() {
              _animationIconController.forward();
            });
          } else {
            controller.sink.add(Animate.reverse);
            setState(() {
              _animationIconController.reverse();
            });
          }
          fabsVisible = !fabsVisible;
        },
        child: AnimatedIcon(
          icon: AnimatedIcons.add_event,
          color: Theme.of(context).colorScheme.onSecondary,
          progress: _animationIconController,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          (_currentIndex != 0
              ? Icons.follow_the_signs_outlined
              : Icons.follow_the_signs_rounded),
          (_currentIndex != 1 ? Icons.group_outlined : Icons.group),
          (_currentIndex != 2
              ? Icons.local_police_outlined
              : Icons.local_police_rounded)
        ],
        activeIndex: _currentIndex,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        activeColor: Theme.of(context).colorScheme.primary,
        onTap: (index) => setState(() => _currentIndex = index),
        //other params
      ),
      // bottomNavigationBar: SalomonBottomBar(
      //   currentIndex: _currentIndex,
      //   onTap: (i) => setState(() => _currentIndex = i),
      //   margin: const EdgeInsets.symmetric(horizontal: 24),
      //   items: [
      //     /// Guest Activity
      //     SalomonBottomBarItem(
      //       icon: Icon(_currentIndex != 0
      //           ? Icons.follow_the_signs_outlined
      //           : Icons.follow_the_signs_rounded),
      //       title: const Text("Guest Activity"),
      //       selectedColor: Colors.purple,
      //     ),

      //     /// Staff Activity
      //     SalomonBottomBarItem(
      //       icon: Icon(_currentIndex != 1 ? Icons.group_outlined : Icons.group),
      //       title: const Text("Staff Activity"),
      //       selectedColor: Colors.pink,
      //     ),

      //     /// Patrolling
      //     SalomonBottomBarItem(
      //       icon: Icon(_currentIndex != 2
      //           ? Icons.local_police_outlined
      //           : Icons.local_police_rounded),
      //       title: const Text("Patrolling"),
      //       selectedColor: Colors.orange,
      //     ),
      //   ],
      // ),
    );
  }

  Widget _body(int index) {
    switch (index) {
      case 0:
        return const GuardGuestActivityPage();
      case 1:
        return const GuardStaffActivityPage();
      case 2:
        return const GuardPatrollPage();
      default:
        return const GuardGuestActivityPage();
    }
  }
}
