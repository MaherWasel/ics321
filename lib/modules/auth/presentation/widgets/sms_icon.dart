import 'package:flutter/material.dart';
import 'package:ics321/constants/icons_path.dart';

class SmSIcon extends StatelessWidget{
  const SmSIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5
        ),
        borderRadius: BorderRadius.circular(100)
      ),
      
      child: Image.asset(
        IconsPath.smsIcon,
        width: sizes.width*0.4,
        
        color: Theme.of(context).colorScheme.primary,
        excludeFromSemantics: true,
        ),
    );
  }
  
}