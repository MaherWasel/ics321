import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ics321/modules/booking/data/%20booking_repository.dart';
import 'package:ics321/modules/booking/presentation/provider/provider.dart';
import 'package:ics321/modules/booking/presentation/screen/booking_confirmation.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/flight.dart';
enum ClassType {First,Economy,Business}
class ClassChoice extends ConsumerWidget{
  final ClassType type;
  final FlightModel flight;

  const ClassChoice({super.key, required this.type, required this.flight});
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
    
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (type == ClassType.Economy)
          const Icon(FontAwesomeIcons.star),
          if (type == ClassType.Business)
           const Icon(FontAwesomeIcons.businessTime),
          if (type == ClassType.First)
            const Icon(FontAwesomeIcons.award),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomText(type.name.tr(),
            color: Theme.of(context).colorScheme.secondary,
            fontsize: 32,),
          ),
        ],
      ),
    );
  }

}