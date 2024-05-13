import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ics321/shared/models/ticket.dart';

class AdminTicketReport extends StatelessWidget{
  final List<Ticket> listOfTickets;

  const AdminTicketReport({super.key, required this.listOfTickets});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text("${listOfTickets.length} ${"totalTickets".tr()}"),
      ),
      body:  ListView.builder(
        itemCount: listOfTickets.length,
        itemBuilder: (context,index)=>
        Card(
          
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                   Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("${"ticketID".tr()} : "),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listOfTickets[index].id),
                  )
                ],
              ),
              Row(
                children: [
                   Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("${"userID".tr()} : "),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listOfTickets[index].user_id!),
                  )
                ],
              ),
              Row(
                children: [
                   Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("status".tr()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listOfTickets[index].status=="Cancelled"?"cancelled".tr():(listOfTickets[index].status=="not paid"?"notPaid".tr():(listOfTickets[index].status=="waitList"?"waitList".tr(): "paid".tr()))),
                  )
                ],
              )
            ],
          ),
        )),
    );
  }

}