import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/booking/presentation/provider/provider.dart';
import 'package:ics321/modules/booking/presentation/screen/booking_confirmation.dart';
import 'package:ics321/modules/booking/presentation/widget/booking_card.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/flight.dart';

class BookingScreen extends ConsumerWidget{
  
   BookingScreen({super.key, required this.flights});
  final List<FlightModel> flights;
  
        final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void nextPage({required BuildContext context ,required WidgetRef ref, required FlightModel flight})async{

            final response =await ref.read(bookingStateProvider.notifier).getAvailableSeats(flight_id: flight.id,
            type: ref.read(bookingStateProvider.notifier).selectedType);
           if (response!=null && response.isNotEmpty){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookingConfirmation(listOfSeats: response, flight: flight)));
           }
           else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("errorTryLater".tr())));
           }

    
  }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: CustomText("bookingScreen".tr()),
      ),
      
      body: ListView.builder(
        itemCount: flights.length,
        itemBuilder: (context,index){
          return BookingCard(flight: flights[index],onClick:()=>nextPage(context: context,ref: ref,flight: flights[index]));
        }),
    );
  }
}