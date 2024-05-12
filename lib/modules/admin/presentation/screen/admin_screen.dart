import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/admin/presentation/provider/provider.dart';
import 'package:ics321/modules/admin/presentation/widget/admin_flight_card.dart';
import 'package:ics321/modules/admin/presentation/widget/date_container.dart';

class AdminScreen extends ConsumerWidget{
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   return ref.watch(flightProvider).when(
    error: (e,v)=>Text(e.toString()), 
    loading: ()=>Center(child: const CircularProgressIndicator()) 
    ,data: (data)=>Column(

      children: [
        DateContainer()
,        Expanded(
          child: ListView.builder(
            shrinkWrap: true,

            itemCount: data.length,
            itemBuilder: (context,index)=>AdminFlightCard(flight: data[index])),
        ),
      ],
    ),);
  }

}