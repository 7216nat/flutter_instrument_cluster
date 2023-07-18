// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';

class SpeedRecognize extends StatelessWidget {
  const SpeedRecognize({Key? key, this.size, required this.speed})
      : super(key: key);
  final Size? size;
  final int speed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size?.width ?? 720,
      height: size?.height ?? 720,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage('images/speed.png'),
            fit:BoxFit.cover),
      ), 
      child:  Center(
        child: (speed >= 100) ? 
          Text(
            speed.toString(),
            style: const TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold, 
                fontSize: 120,
                backgroundColor: Colors.white
                ),
          ) : Text(
            speed.toString(),
            style: const TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold, 
                fontSize: 168,
                backgroundColor: Colors.white
                ),
          ),
      ),
    );
  }
}
