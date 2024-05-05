import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ics321/modules/booking/domain/plane.dart';
import 'package:ics321/modules/booking/presentation/widget/plane_card.dart';

class PlaneInfoScreen extends StatelessWidget{
  const PlaneInfoScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const PlaneCard()
    );
  }

}