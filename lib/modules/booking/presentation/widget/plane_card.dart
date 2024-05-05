import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/booking/domain/plane.dart';
import 'package:ics321/modules/booking/presentation/provider/provider.dart';
import 'package:ics321/modules/booking/presentation/widget/plane_icon.dart';
import 'package:ics321/shared/custom_text.dart';

class PlaneCard extends ConsumerWidget{


  const PlaneCard({super.key});
  getFormatedDate(_date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(_date);
      var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
    }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sizes=MediaQuery.of(context).size;
    final Plane plane =ref.read(bookingStateProvider.notifier).selectedPlane!;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          PlaneIcon(),
          if (plane.name!=null)
          Row(
            children: [
              const Icon(Icons.flight),
              Text("planeName".tr())

            ],
          ),
          if (plane.airCraftType!=null)
          Row(
            children: [
              const Icon(Icons.type_specimen),
              Text("airCraftType".tr())

            ],
          ),
          if (plane.prev_maintanance!=null)
          Row(
            children: [
              const Icon(Icons.calendar_month),
              CustomText("prev_maintanance".tr()),
              CustomText(getFormatedDate(plane.prev_maintanance.toString()))
            ],
          ),
          if (plane.next_maintanance!=null)
          Row(
            children: [
              const Icon(Icons.calendar_month),
              CustomText("next_maintanance".tr()),
              CustomText(getFormatedDate(plane.next_maintanance.toString()))
            ],
          ),
          if (plane.num_Eco!=null)
          Row(
            children: [

              CustomText("numOfEco".tr()),
              CustomText(plane.num_Eco.toString())
            ],
          ),
          if (plane.num_first!=null)
          Row(
            children: [

              CustomText("numOfBus".tr()),
              CustomText(plane.num_bus.toString())
            ],
          ),
          if (plane.num_first!=null)
          Row(
            children: [

              CustomText("numOfFir".tr()),
              CustomText(plane.num_first.toString())
            ],
          )
        ],
      ),
    );
  }

}