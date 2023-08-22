import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rnginfra/src/core/widgets/loading.bar.dart';
import 'package:rnginfra/src/residents/visitors/presentation/visitors/widgets/add.visitor.frequent.slide.dart';
import 'package:rnginfra/src/residents/visitors/presentation/visitors/widgets/add.visitor.once.slide.dart';
import '../../../../../../main/injectable/getit.dart';
import '../controller/add.visitor.activity.controller.dart';

class AddVisitorActivityPage extends StatefulWidget {
  const AddVisitorActivityPage({super.key});

  @override
  State<AddVisitorActivityPage> createState() => _AddVisitorActivityPageState();
}

class _AddVisitorActivityPageState extends State<AddVisitorActivityPage>
    with SingleTickerProviderStateMixin {
  late AddVisitorActivityController controller;

  @override
  void initState() {
    controller = getIt<AddVisitorActivityController>();
    controller.init();
    controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Hero(
      tag: 'VISITOR_ACTIVITY',
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => (controller.saving.value)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: LoadingBar(
                          color: Theme.of(context).colorScheme.secondary,
                          backColor: Theme.of(context).cardColor,
                        ),
                      )
                    : const SizedBox()),
                const SizedBox(
                  height: 10,
                ),
                TabBar(
                  onTap: (value) {
                    if (value == 1) {
                      controller.visitation.value
                          .field_guest_freq_multiple_entry = true;
                    } else {
                      controller.visitation.value
                          .field_guest_freq_multiple_entry = false;
                    }
                  },
                  labelColor: Theme.of(context).colorScheme.onBackground,
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground),
                  tabs: const [Tab(text: "Once"), Tab(text: "Frequently")],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (7 / 12),
                  child: TabBarView(
                    children: [
                      AddVisitorOnceSlide(controller: controller),
                      AddVisitorFrequentSlide(
                        controller: controller,
                        restorationId: '123',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
