import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/shared/models/plane.dart';
import 'package:ics321/modules/booking/presentation/provider/provider.dart';
import 'package:ics321/modules/booking/presentation/widget/plane_icon.dart';
import 'package:ics321/shared/custom_text.dart';

class PlaneCard extends ConsumerWidget{


  const PlaneCard({required this.plane,super.key});
  final Plane plane;
  getFormatedDate(_date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(_date);
      var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
    }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sizes=MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,

      child: Card(
        child: Column(
          children: [
            PlaneIcon(),
            if (plane.name!=null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: const Icon(Icons.flight),
                  ),
                  CustomText("planeName".tr(),
                  fontsize: 20,),
                  CustomText(" : ${plane.name}",
                  fontsize: 20,)
                      
                ],
              ),
            ),
            if (plane.airCraftType!=null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: const Icon(Icons.type_specimen),
                  ),
                  CustomText("airCraftType".tr(),
                  fontsize: 20),
                  CustomText(" : ${plane.airCraftType}",
                  fontsize: 20,)
                      
                ],
              ),
            ),
            if (plane.prev_maintanance!=null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: const Icon(Icons.calendar_month),
                  ),
                  CustomText("prev_maintanance".tr(),
                  fontsize: 20),
                  CustomText(" : "+ getFormatedDate(plane.prev_maintanance.toString()),
                    fontsize: 20,)
                ],
              ),
            ),
            if (plane.next_maintanance!=null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: const Icon(Icons.calendar_month),
                  ),
                  CustomText("next_maintanance".tr(),
                  fontsize: 20),
                  CustomText(" : "+getFormatedDate(plane.next_maintanance.toString()),
                  fontsize: 20,)
                ],
              ),
            ),
            if (plane.num_Eco!=null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                      
                  CustomText("numOfEco".tr(),
                  fontsize: 20),
                  CustomText(" : ${plane.num_Eco}",
                  fontsize: 20,)
                ],
              ),
            ),
            if (plane.num_first!=null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                      
                  CustomText("numOfBus".tr(),
                  fontsize: 20),
                  CustomText(" : ${plane.num_bus}",
                  fontsize: 20,)
                ],
              ),
            ),
            if (plane.num_first!=null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                      
                  CustomText("numOfFir".tr(),
                  fontsize: 20),
                  CustomText(" : "+plane.num_first.toString(),
                  fontsize: 20,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}