import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ics321/modules/booking/presentation/widget/booking_card.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/flight.dart';

class BookingScreen extends StatelessWidget{
  
  const BookingScreen({super.key, required this.flights});
  final List<FlightModel> flights;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: CustomText("bookingScreen".tr()),
      ),
      
      body: ListView.builder(
        itemCount: flights.length,
        itemBuilder: (context,index){
          return BookingCard(flight: flights[index]);
        }),
    );
  }
}