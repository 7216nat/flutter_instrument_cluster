import 'package:flutter/material.dart';

class WarningPopup extends StatefulWidget {
  const WarningPopup({Key? key, required this.speed}) : super(key: key);
  final bool speed;

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
    curve: Curves.fastEaseInToSlowEaseOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.speed) {
      return const SizedBox.shrink();
    } else {
      return FadeTransition(
        opacity: _animation,
        child: Container(
          width: 400,
          height: 400,
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
