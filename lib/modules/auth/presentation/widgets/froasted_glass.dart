
import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox(
      {Key? key,
      required this.width,
      required this.height,
      required this.child})
      : super(key: key);

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: width,
        height: height,
        color: Color.fromARGB(56, 0, 255, 162),
        child: Stack(
          children: [

            BackdropFilter(
              filter: ImageFilter.blur(

                sigmaX: 4.0,

                sigmaY: 4.0,
              ),

              child: Container(),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      //begin color  
                      Colors.white.withOpacity(0.15),
                      //end color
                      Colors.white.withOpacity(0.05),
                    ]),
              ),
            ),

            Center(child: child),
          ],
        ),
      ),
    );
  }
}