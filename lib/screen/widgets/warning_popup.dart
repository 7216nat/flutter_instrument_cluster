import 'package:flutter/material.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/speed_warning.dart';

class WarningPopup extends StatefulWidget {
  WarningPopup(
      {Key? key,
      required this.obstacleDetect,
      required this.speed,
      required this.acceleration,
      required this.speedSign,
      required this.screenWidth,
      required this.screenHeight})
      : super(key: key);
  final bool obstacleDetect;
  final double speed;
  final double acceleration;
  final double speedSign;
  final double screenWidth;
  final double screenHeight;

  @override
  _WarningPopupState createState() => _WarningPopupState();
}

class _WarningPopupState extends State<WarningPopup>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.obstacleDetect) {
      if (widget.speed > widget.speedSign && widget.acceleration > 0) {
        return SpeedWarning(
            speedLimit: widget.speedSign,
            screenHeight: widget.screenHeight,
            screenWidth: widget.screenWidth);
      }
      return const SizedBox.shrink();
    } else {
      return FadeTransition(
        opacity: _animation,
        child: Container(
          width: (150 * widget.screenWidth) / 480,
          height: (250 * widget.screenHeight) / 480,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
                image: AssetImage('images/collision_warning.jpg'),
                fit: BoxFit.cover),
          ),
        ),
      );
    }
  }
  //   return Container(
  //     width: 400,
  //     height: 400,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       image: const DecorationImage(
  //           image: AssetImage('images/collision_warning.jpg'),
  //           fit: BoxFit.cover),
  //     ),
  //   );
  // }
}
