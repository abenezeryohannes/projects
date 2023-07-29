import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:rnginfra/src/core/animations/fade.animation.dart';
import 'package:rnginfra/src/core/animations/position.animation.dart';
import 'package:rnginfra/src/guards/activity/presentation/guests/pages/guest.activity.page.dart';
import 'package:rnginfra/src/guards/activity/presentation/guests/pages/add.guest.activity.page.dart';
import 'package:rnginfra/src/guards/activity/presentation/staffs/pages/add.staff.attendance.page.dart';
import 'package:rnginfra/src/guards/patroll/presentation/patrolls_list/pages/guard.patroll.page.dart';
import 'package:rnginfra/src/guards/activity/presentation/staffs/pages/guard.staff.attendance.page.dart';
import 'package:rnginfra/src/guards/patroll/presentation/scan_patrolls/page/scan.patroll.page.dart';

import '../core/animations/animate.dart';

class GuardMainPage extends StatefulWidget {
  const GuardMainPage({super.key});

  @override
  State<GuardMainPage> createState() => _GuardMainPageState();
}

class _GuardMainPageState extends State<GuardMainPage>
    with SingleTickerProviderStateMixin {
//
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();
//
  GuardGuestActivityPage? _activityPage;
  GuardStaffAttendancePage? _attendancePage;
//
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

  List<int> indexStack = [];
  Future<bool> _onWillPop() async {
    if (indexStack.isEmpty) {
      return true;
    } else {
      if (indexStack.last == 0) {
        _activityPage = null;
      }
      if (indexStack.last == 1) {
        _attendancePage = null;
      }
      setState(() {
        _currentIndex = indexStack.last;
      });
      indexStack.removeLast();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                      padding: const EdgeInsets.only(right: 10, bottom: 8),
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
                                                  const ScanPatrollPage()))
                                      .then((value) {
                                    if (value != null) {
                                      _attendancePage!.reload();
                                    }
                                  });
                                  ;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    'Staff Activity',
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
                            heroTag: 'STAFF_ACTIVITY',
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AddStaffAttendance();
                                  }).then((value) {
                                if (value != null) {
                                  _attendancePage!.reload();
                                }
                              });
                              ;
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
                      padding: const EdgeInsets.only(bottom: 30.0, right: 6),
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
                                                const AddActivityPage()))
                                    .then((value) {
                                  // if (value != null) {
                                  _activityPage!.reload();
                                  // }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  'Guest Activity',
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
                                  const EdgeInsets.only(right: 10.0, bottom: 8),
                              child: FloatingActionButton(
                                  heroTag: 'GUEST_ACTIVITY',
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AddActivityPage();
                                        }).then((value) {
                                      if (value != null) {
                                        _activityPage!.reload();
                                      }
                                    });
                                  },
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  child: Icon(
                                    Icons.add,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            _reverseOnEachClickFab();
            if (fabsVisible) {
              Future.delayed(const Duration(seconds: 3), _hideFabs);
            }
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
          onTap: (index) {
            if (index == 0) {
              _activityPage = null;
            }
            if (index == 1) {
              _attendancePage = null;
            }
            if (indexStack.contains(_currentIndex)) {
              indexStack.removeWhere((element) => element == _currentIndex);
            }
            indexStack.add(_currentIndex);
            setState(() => _currentIndex = index);
          },
          //other params
        ),
      ),
    );
  }

  void _reverseOnEachClickFab() {
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
  }

  void _hideFabs() {
    if (fabsVisible) {
      controller.sink.add(Animate.reverse);
      setState(() {
        _animationIconController.reverse();
      });
      fabsVisible = !fabsVisible;
    }
  }

  Widget _body(int index) {
    switch (index) {
      case 0:
        _activityPage ??= GuardGuestActivityPage();
        return _activityPage!;
      case 1:
        _attendancePage ??= GuardStaffAttendancePage();
        return _attendancePage!;
      case 2:
        return const GuardPatrollPage();
      default:
        _activityPage ??= GuardGuestActivityPage();
        return _activityPage!;
    }
  }
}
