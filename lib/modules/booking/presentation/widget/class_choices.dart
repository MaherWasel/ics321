import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/booking/presentation/provider/provider.dart';
import 'package:ics321/modules/booking/presentation/widget/class_choice.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/flight.dart';

class ClassChoices extends ConsumerWidget{
  final FlightModel flight;
  final Function onClick;
  const ClassChoices( {required this.onClick ,super.key, required this.flight});
  

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final bookingState= ref.watch(bookingStateProvider);
    return  Card(
          margin: const EdgeInsets.all(0),
          color: Theme.of(context).colorScheme.primary,
          child:  Builder(
            builder: (context) {
              if (bookingState is BookingLoading){
                return const Center(
                  child: 
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText("Select a Class Type",
                  fontsize: 32,
                  color: Colors.white,),
                  InkWell(
                    onTap: (){
                      ref.read(bookingStateProvider.notifier).selectedType="Economy";
                      onClick();
                      
                    },
                    child: ClassChoice(type: ClassType.Economy,flight: flight,)),
                  InkWell(
                    onTap: (){
                      ref.read(bookingStateProvider.notifier).selectedType="Business";
                      onClick();
                      
                    },
                    child: ClassChoice(type: ClassType.Business,flight: flight,)),

                  InkWell(
                    onTap: (){
                      ref.read(bookingStateProvider.notifier).selectedType="First";
                      onClick();
                      
                    },
                    child: ClassChoice(type: ClassType.First,flight: flight,))
                ],
              );
            }
          ),
        
      
    );
  }

}