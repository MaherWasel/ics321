import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/admin/presentation/provider/provider.dart';
import 'package:ics321/modules/admin/presentation/screen/admin_tickets_report.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/flight.dart';

class ManageBottomSheet extends ConsumerWidget{
  const ManageBottomSheet({required this.fligth, super.key});
  final FlightModel fligth;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final adminStates  = ref.watch(adminControllerProvider);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Builder(
        builder: (context) {
          if (adminStates is AdminLoading ){
            return Center(child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.white,
            ));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: double.infinity,
          
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
              ],
                  
                ),
                margin: const EdgeInsets.all(8),
                child:  Center(
                  child: CustomText("manageWaitLists".tr()),
                ),
              ),
              InkWell(
                onTap: ()async{
                  final response = await ref.read(adminControllerProvider.notifier).getFlightTickets(flight: fligth);
                  if (response!=null && response.isNotEmpty){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminTicketReport(listOfTickets: response)));
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("noTicketAreBooked".tr())));
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    
                  ),
                  margin: const EdgeInsets.all(8),
                  child:  Center(
                    child: CustomText("generateReports".tr()),
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }

}