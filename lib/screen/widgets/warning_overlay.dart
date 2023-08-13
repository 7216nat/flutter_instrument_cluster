import 'package:flutter/material.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/warning_popup.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class WarningOverlay extends ConsumerWidget {
  const WarningOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final vehicle = ref.watch(vehicleSignalProvider);
    final windowHeight = MediaQuery.of(context).size.height;
    final windowWidth = MediaQuery.of(context).size.width;

    double screenHeight = windowHeight;
    double screenWidth = windowWidth;

    double ratHeight = (windowWidth * 9) / 16;
    double ratWidth = (windowHeight * 16) / 9;

    if (ratWidth <= windowWidth) {
      screenHeight = windowHeight;
      screenWidth = ratWidth;
    } else {
      screenHeight = ratHeight;
      screenWidth = windowWidth;
    }
    return Center(
        child: WarningPopup(
      obstacleDetect: vehicle.obstacleDetect,
      speed: vehicle.speed,
      acceleration: vehicle.acceleration,
      speedSign: vehicle.trafficSign,
      screenHeight: screenHeight,
      screenWidth: screenWidth,
    ));
  }
}
