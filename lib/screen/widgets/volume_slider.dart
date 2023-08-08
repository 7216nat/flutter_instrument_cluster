import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VolumeSlider extends StatefulWidget {
  VolumeSlider({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.sliderHeight,
  }) : super(key: key);
  final double screenHeight;
  final double screenWidth;
  final double sliderHeight;

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider>
    with TickerProviderStateMixin {
  double _currentSliderValue = -1;

  double calcPadding(double value, double height) {
    // values wrt to values at 720 height
    return (value * height) / 720;
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastEaseInToSlowEaseOut,
  );

  @override
  void initState() {
    super.initState();
    repeatOnce();
  }

  @override
  void didUpdateWidget(covariant VolumeSlider oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (_currentSliderValue != widget.sliderHeight) {
      repeatOnce();
      _currentSliderValue = widget.sliderHeight;
    }
  }

  void repeatOnce() async {
    await _controller.forward();
    await _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      // El cuadro verde debe ser el hijo de AnimatedOpacity
      child: Padding(
        padding: EdgeInsets.fromLTRB(calcPadding(450, widget.screenHeight), 10,
            calcPadding(450, widget.screenHeight), 30),
        child: Scaffold(
          body: Slider(
            value: _currentSliderValue,
            max: 100,
            divisions: 5,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
