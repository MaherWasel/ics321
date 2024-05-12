import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ics321/modules/booking/domain/seat.dart';
import 'package:ics321/modules/booking/presentation/provider/provider.dart';
import 'package:ics321/shared/plane_info.dart';
import 'package:ics321/modules/booking/presentation/screen/splash_screen.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/flight.dart';

class BookingConfirmation extends ConsumerStatefulWidget{
  final List<Seat> listOfSeats;
  final FlightModel flight;
   const BookingConfirmation({super.key, required this.listOfSeats, required this.flight});

  @override
  ConsumerState<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends ConsumerState<BookingConfirmation> {
  String?selectedSeat;
  getFormatedDate(DateTime _date, bool time) {

    if (time){
    return DateFormat.jms().format(_date);
     

    }
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date);

    }
  @override
  Widget build(BuildContext context) {
    final bookingState= ref.watch(bookingStateProvider);
    final sizes=MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: CustomText(
          "bookingConfirmation".tr()
        ),
      ),
      body:  Center(
        child: Card(
          child: SizedBox(
            height: sizes.height/2,
            child: Column(
            
              children: [
                Row(
                  children: [
                    
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.flight_takeoff),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(widget.flight.source,
                      fontsize: 20,),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.flight_land),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(widget.flight.destination,fontsize: 20,),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.calendar_month),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(getFormatedDate(widget.flight.date,false).toString(),fontsize: 20,),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.schedule),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(getFormatedDate(widget.flight.date,true).toString(),fontsize: 20,),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.moneyBill),
                    ),
                    if (ref.read(bookingStateProvider.notifier).selectedType=="Economy")
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(widget.flight.economy_price.toString(),fontsize: 20,),
                    ),
                    if (ref.read(bookingStateProvider.notifier).selectedType=="First")
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(widget.flight.first_price.toString()),
                    ),
                    if (ref.read(bookingStateProvider.notifier).selectedType=="Business")
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(widget.flight.business_price.toString()),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextButton(onPressed: ()async{
                         await ref.read(bookingStateProvider.notifier).getPlane(planeId: widget.flight.planeId);
            
                      if (ref.read(bookingStateProvider.notifier).selectedPlane!=null){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PlaneInfoScreen(plane: ref.read(bookingStateProvider.notifier).selectedPlane!,)));
            
                      }
                      }, child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.info),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text("planeInfo".tr()),
                          )
                        ],
                      )),
                    )
                  ],
                ),
                Row(
                  children: [
                    if (selectedSeat!=null)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomText("Selected Seat"),
                    ),
            
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                              
                                      
                                      hint:  CustomText('seatLocation'.tr(),fontsize: 28,),
                      
                                      value: selectedSeat,
                                      items:widget.listOfSeats.map((e)  {
                                    return DropdownMenuItem<String>(
                                      
                                      value: e.location,
                                      child: CustomText(
                                        e.location,
                                        fontsize: 32,),
                                      
                                    );
                                      }).toList(),
                            
                            
                                      onChanged: (_) {
                                        setState(() {
                                        selectedSeat=_??"";
                            
                                        });
                            
                                        
                                      },
                                      
                                    ),
                    ),
                  ],
                ),
                const Spacer(),
                if (selectedSeat!=null)
                Builder(
                  builder: (context) {
                    if (bookingState is BookingLoading){
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: sizes.width/2,
                        height: 60,
                        child: CustomButton(child: Text("submit".tr()), onPressed: ()async{
                          double price=0;
                          if (ref.read(bookingStateProvider.notifier).selectedType=="Economy"){
                            price=widget.flight.economy_price!;

                          }
                           else if (ref.read(bookingStateProvider.notifier).selectedType=="Business"){
                            price=widget.flight.business_price!;

                           }
                           else {
                            price=widget.flight.first_price!;

                           }
                          await ref.read(bookingStateProvider.notifier).sendTicket(flight_id: widget.flight.id, price: price, seatLocation: selectedSeat!);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const SuccessBookingScreen()));
                        })),
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}