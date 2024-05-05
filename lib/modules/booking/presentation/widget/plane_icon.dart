import 'package:flutter/material.dart';
import 'package:ics321/constants/icons_path.dart';

class PlaneIcon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Image.asset(IconsPath.planeIcon,fit: BoxFit.cover,);
  }

}