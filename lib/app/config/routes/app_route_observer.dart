import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRouteObserver extends GetObserver {

  final RxString currentRouteName = "".obs;

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      currentRouteName.value = route.settings.name!;
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute?.settings.name != null) {
      currentRouteName.value = previousRoute!.settings.name!;
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (previousRoute?.settings.name != null) {
      currentRouteName.value = previousRoute!.settings.name!;
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute?.settings.name != null) {
      currentRouteName.value = newRoute!.settings.name!;
    }
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {}

  @override
  void didStopUserGesture() {}
}

final appRouteObserver = AppRouteObserver();