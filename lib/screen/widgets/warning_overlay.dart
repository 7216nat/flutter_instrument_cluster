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
    return Center(
        child: WarningPopup(
      speed: vehicle.obstacleDetect,
    ));
  }
}
