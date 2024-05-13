import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/booking/presentation/provider/provider.dart';
import 'package:ics321/modules/booking/presentation/screen/booking_confirmation.dart';
import 'package:ics321/modules/booking/presentation/screen/splash_screen.dart';
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
            // ignore: use_build_context_synchronously
            showDialog(context: context, builder: (context)=>
            Center(child: Container(
              height: 150,
              width: 350,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("noSeats".tr()),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("waitListRegister".tr()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text("no".tr())),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: ()async{
                          double price=0;
                           if (ref.read(bookingStateProvider.notifier).selectedType=="Economy"){
                            price=flight.economy_price!;

                          }
                           else if (ref.read(bookingStateProvider.notifier).selectedType=="Business"){
                            price=flight.business_price!;

                           }
                           else {
                            price=flight.first_price!;

                           }
                      
                          await ref.read(bookingStateProvider.notifier).sendTicket(flight_id: flight.id, price:price , seatLocation: null,status: "waitList");
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SuccessBookingScreen()));
                        }, child: Text("yes".tr())),
                      )
                    ],
                  )
                ],
              ))));
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