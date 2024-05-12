import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


import 'package:ics321/modules/booking/presentation/widget/plane_card.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/plane.dart';

class PlaneInfoScreen extends StatelessWidget{
  const PlaneInfoScreen({super.key, required this.plane});
  final Plane plane;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: CustomText("planeInfoSc".tr()),
      ),
      body:  PlaneCard(plane: plane,)
    );
  }

}