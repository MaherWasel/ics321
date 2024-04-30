import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  const CustomButton({super.key, required this.child, required this.onPressed});

  final void Function()? onPressed;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).colorScheme.background,
    side:  BorderSide(color:Theme.of(context).colorScheme.primary, width: 2)), 
      child: child,);
  }

}