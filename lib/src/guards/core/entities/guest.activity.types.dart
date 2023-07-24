import 'package:get/utils.dart';

import '../../activity/domain/entities/activity.type.entity.dart';

class GuestActivityTypes {
  static List<ActivityTypeEntity> activities = const [
    ActivityTypeEntity(
        name: "Delivery",
        icon: "assets/icon/delivery.png",
        color: "0xFFFF7043",
        needApproval: true),
    ActivityTypeEntity(
        name: "Cab",
        icon: "assets/icon/cab.png",
        color: "0xFF039BE5",
        needApproval: true),
    ActivityTypeEntity(
        name: "Guest",
        icon: "assets/icon/guest.png",
        color: "0xFF26A69A",
        needApproval: true),
    ActivityTypeEntity(
        name: "Help",
        icon: "assets/icon/home_service.png",
        color: "0xFF5C6BC0",
        needApproval: true),
  ];

  static ActivityTypeEntity? getType(String val) {
    return activities.firstWhereOrNull((element) =>
        (element.name.toLowerCase().contains(val.toLowerCase())) ||
        (val.toLowerCase().contains(element.name.toLowerCase())));
  }
}
