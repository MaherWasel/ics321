import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/my_tickets/data/ticket_repository.dart';
import 'package:ics321/modules/my_tickets/presentation/provider/provider.dart';
import 'package:ics321/modules/my_tickets/presentation/widget/ticket_card.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:uuid/uuid.dart';

class MyTicketsScreen extends StatefulWidget{
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  @override
  Widget build(BuildContext context) {
    print(Utils.userId);
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
          if (listOfTickets.isEmpty){
            return Center(
              child: CustomText("noTicketsFound"),
            );
          }
          return ListView.builder(
            itemCount: listOfTickets.length,
            itemBuilder: (context,index){
              return TicketCard(ticket: listOfTickets[index]);
            });
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