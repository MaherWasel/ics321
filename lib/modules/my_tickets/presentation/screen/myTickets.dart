import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/my_tickets/data/ticket_repository.dart';
import 'package:ics321/modules/my_tickets/presentation/provider/provider.dart';
import 'package:ics321/modules/my_tickets/presentation/widget/ticket_card.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/ticket.dart';
import 'package:uuid/uuid.dart';

class MyTicketsScreen extends StatefulWidget{
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  bool showCancelled=false;
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: TicketRepository().getTickets(userId: UuidValue.fromString(Utils.user!.id).toFormattedString()), 
      builder: (context,snapshot){
        if (snapshot.connectionState ==ConnectionState.waiting){
          return const Center(
            child: 
            CircularProgressIndicator(),
          );
        }
        

        else if (snapshot.hasData && snapshot.data!=null){
          final listOfTickets= snapshot.data!;
          final List<Ticket> filteredTickets=listOfTickets.where((element) => element.status!="Cancelled").toList();
          if (listOfTickets.isEmpty){
            return Center(
              child: CustomText("noTicketsFound".tr()),
            );
          }
          return Column(
            children: [
              ListTile(
                leading: Icon(showCancelled? Icons.radio_button_checked:Icons.radio_button_off),
                title: Text("removeCancelled".tr()),
                onTap: (){
                  setState(() {
                    showCancelled=!showCancelled;
                  });
                },
              ),
              if (showCancelled && filteredTickets.isEmpty)
              Center(
              child: CustomText("noTicketsFound".tr()),
            ),
              Expanded(
                child: ListView.builder(
                  
                  itemCount: showCancelled?filteredTickets.length: listOfTickets.length,
                  itemBuilder: (context,index){
                    return TicketCard(ticket: showCancelled?filteredTickets[index]: listOfTickets[index],refresh: ()=>setState(() {
                    
                  }),);
                  }),
              ),
            ],
          );
        }
        else if (snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        
        else {
          return TextButton
          (child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh),
              Text("refresh"),
            ],
          ), onPressed: (){
            setState(() {
              
            });
          });
        }
      });
  }
}