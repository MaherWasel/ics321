import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/shared/models/ticket.dart';
import 'package:ics321/modules/my_tickets/presentation/provider/provider.dart';
import 'package:ics321/modules/my_tickets/presentation/widget/ticket_cancelation.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/plane_info.dart';

import 'package:uuid/uuid_value.dart';

class TicketCard extends ConsumerWidget{
  final Ticket ticket;
  final Function refresh;
  const TicketCard( {super.key,required this.refresh, required this.ticket});
  getFormatedDate(DateTime _date, bool time) {

    if (time){
    return DateFormat.jms().format(_date);
     

    }
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date);

    }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
  final paymentState= ref.watch(myTicketPaymentProvider);
   return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (ticket.status!="Cancelled")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0,
                  vertical: 2),
                  child: TextButton(
                    onPressed: (){
                      showDialog(context: context, builder: (context)=> Center(child: TicketCancelation(ticket,()=>refresh())));
                    },
                    child:  Row(
                      children: [
                        CustomText("deleteTicket".tr()),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(Icons.delete),
                        ),
                      ],
                    )),
                )
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.flight_takeoff),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ticket.flight!.source),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.flight_land),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(ticket.flight!.destination),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.calendar_month),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(getFormatedDate(ticket.flight!.date,false)),
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.schedule),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(getFormatedDate(ticket.flight!.time, true)),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(onPressed: ()async{
                    final response =await ref.read(myTicketsProvider.notifier).getPlane(planeId: ticket.flight!.planeId);

                  if (response!=null){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlaneInfoScreen(plane: response,)));

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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(FontAwesomeIcons.moneyCheckDollar,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(ticket.price.toString()),
                ),
                CustomText("sr".tr()),
                const Spacer(),

                CustomText("status".tr()),
                const SizedBox(
                  width: 10,
                ),
                CustomText(ticket.status??("notPaid".tr())),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.chair_sharp),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(ticket.seat_location??""),
                )
              ],
            ),
            if (ticket.status=="not paid")
            SizedBox(
              width:300,
              child: CustomButton(
                child: CustomText("pay".tr()), onPressed: () {
                  showBottomSheet(context: context, builder: (context)=>Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                        ),
                        child: Builder(
                          builder: (context) {
                             if (paymentState is TicketLoading){
                        return const Center(
                          child: const CircularProgressIndicator(),
                        );
                      }
                     
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CustomText("Pay With:",fontsize: 32,
                                  color: Colors.white,),
                                ),
                                InkWell(
                                  onTap: ()async {
                                    await ref.read(myTicketPaymentProvider.notifier).payTicket(ticket: ticket, user_id: UuidValue.fromString(Utils.userId).toFormattedString());
                                    Navigator.pop(context);
                                    refresh();
                                    
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    height: 60,
                                                        
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white
                                    ),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.credit_card),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CustomText("With credit card"),
                                          )],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: ()async{
                                    await ref.read(myTicketPaymentProvider.notifier).payTicket(ticket: ticket, user_id: UuidValue.fromString(Utils.userId).toFormattedString());
                                    Navigator.pop(context);
                                    refresh();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    height: 60,
                                                        
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white
                                    ),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(FontAwesomeIcons.applePay,size: 36,),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CustomText("With Apple Pay"),
                                          )],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                          

                    
                  ));
                }),
            )
            else 
            Container(
              width:300,
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(100)
              
              ),
              child: Center(child:  CustomText(ticket.status!,
              color: Theme.of(context).colorScheme.primary,)),
            )
            

          ],
        ),
      ),
    );
  }

}