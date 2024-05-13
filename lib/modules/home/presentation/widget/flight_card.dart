import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/booking/presentation/screen/booking.dart';
import 'package:ics321/modules/home/presentation/provider/providers.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';

class FlightCard extends ConsumerStatefulWidget{
   FlightCard({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return FlightCardState();
  }

}
class FlightCardState extends ConsumerState<FlightCard>{
  String? selectedSource;
  String? destination;
  DateTime? pickedDate;
  
  getFormatedDate(_date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(_date);
      var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
    }
  
  @override
  Widget build(BuildContext context) {
    
    final homeStates =ref.watch(homeControllerProvider);
    final sizes =MediaQuery.of(context).size;

    return Builder(
      builder: (context) {
        if (homeStates is HomeIntial){
          return TextButton(onPressed: ()async {
            final response =await ref.read(homeControllerProvider.notifier).getAllFlights();
            
          }, child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CustomText(
                "getStarted".tr(),fontsize: 32,),
              const SizedBox(
                height: 12,
              ),
              const Icon(Icons.download_rounded,size: 36,)
            ],
          ));
        }
        else if (homeStates is HomeLoading){
          return const Center(child: CircularProgressIndicator());
        }
    
        return Card(
          
          child: SizedBox(
            width: sizes.width*0.85,
            height: 250,
            child: Column(
              children: [
                
                
                SizedBox(
                  width: sizes.width*0.7,
                  child: DropdownButton<String>(
                    
                            
                            hint:  Text('source'.tr()),
                            isExpanded: true,
                            value: selectedSource,
                            items:ref.read(homeControllerProvider.notifier).uniqueSources.map((e)  {
                          return DropdownMenuItem(
                            
                            value: e,
                            child: CustomText(
                              e,
                              fontsize: 22,),
                            
                          );
                            }).toList(),
                  
                  
                            onChanged: (_) {
                              setState(() {
                              selectedSource=_??"";
                  
                              });
                  
                              
                            },
                            
                          ),
                ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: sizes.width*0.7,
                          child: DropdownButton<String>(
                                          
                            isExpanded: true,
                            hint:  Text('destination'.tr()),
                            value: destination,
                            items: ref.read(homeControllerProvider.notifier).uniqueDestinations .map((e)  {
                          return DropdownMenuItem(
                            value: e,
                            child: CustomText(
                              
                              e,
                              fontsize: 22,),
                            
                          );
                            }).toList(),
                                          
                                          
                            onChanged: (_) {
                              setState(() {
                              destination=_??"";
                                          
                              });
                                          
                              
                            },
                            
                          ),
                        ),
                        
                        Row(
                          children: [
                            const SizedBox(
                          width: 15,
                        ),
                            IconButton(
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: ()async {
                              pickedDate=await showDatePicker(
                                                  context: context,
                                                   initialDate: DateTime.now(), //get today's date
                                                  firstDate:DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2025)
                                              );
                              setState(() {
                                
                              });
                            
                            }, icon: const Icon(Icons.date_range)),
                            if (pickedDate != null)
                            CustomText(
                              
                              getFormatedDate(pickedDate.toString(),
                              
                              ),
                              color: Theme.of(context).colorScheme.primary,
                            )
                          ],
                        ),
                        SizedBox(
                          width: sizes.width*0.7,
                          child: Row(
                            children: [
                              TextButton(onPressed: (){
                                setState(() {
                                  selectedSource=null;
                                  destination=null;
                                  pickedDate=null;
                                });
                              }, child: Text("reset".tr())),
                              CustomButton(child: Text("searchForFlights".tr()), onPressed: (){
                                final filteredFlights=ref.read(homeControllerProvider.notifier).filterFlights(date: pickedDate,source: selectedSource,destination: destination);
                                if (filteredFlights.isNotEmpty){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookingScreen(flights: filteredFlights)));
                                }
                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CustomText(
                                    "noFlightsFound".tr(),
                                    fontsize: 20,)));
                                }
                              }),
                            ],
                          ))
              ],
            ),
          ),
        );
      }
    );
  }
  
}