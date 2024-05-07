import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ics321/modules/my_tickets/domain/ticket.dart';
import 'package:ics321/modules/my_tickets/presentation/widget/ticket_cancelation.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';

class TicketCard extends StatelessWidget{
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});
  getFormatedDate(DateTime _date, bool time) {

    if (time){
    return DateFormat.jms().format(_date);
     

    }
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date);

    }
  @override
  Widget build(BuildContext context) {
   return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0,
                  vertical: 2),
                  child: TextButton(
                    onPressed: (){
                      showDialog(context: context, builder: (context)=> Center(child: TicketCancelation()));
                    },
                    child:  Row(
                      children: [
                        CustomText("deleteTicket".tr()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                CustomText(ticket.status??"notPaid".tr()),
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
            if (ticket.status==null)
            SizedBox(
              width:300,
              child: CustomButton(
                child: CustomText("pay".tr()), onPressed: () {

                }),
            ),
            

          ],
        ),
      ),
    );
  }

}