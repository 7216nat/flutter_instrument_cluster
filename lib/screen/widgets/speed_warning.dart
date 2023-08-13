import 'package:flutter/material.dart';

class SpeedWarning extends StatefulWidget {
  const SpeedWarning(
      {Key? key,
      required this.speedLimit,
      required this.screenHeight,
      required this.screenWidth})
      : super(key: key);
  final double speedLimit;
  final double screenWidth;
  final double screenHeight;

  @override
  _SpeedWarningState createState() => _SpeedWarningState();
}

class _SpeedWarningState extends State<SpeedWarning> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: (120 * widget.screenWidth) / 480,
        height: (250 * widget.screenHeight) / 480,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage('images/blank.png'), fit: BoxFit.cover),
              ),
            ),
            const Spacer(),
            Text(
              'Speed \n ${widget.speedLimit.ceil().toString()} km/h \n exceeded',
              textAlign: TextAlign.center,
              style: TextStyle(
                inherit: false,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
