import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ics321/modules/admin/presentation/widget/wait_list_card.dart';
import 'package:ics321/shared/models/ticket.dart';

class AdminWaitListScreen extends StatelessWidget{
  const AdminWaitListScreen({super.key, required this.listOfWaitListsTickets});
  final List<Ticket> listOfWaitListsTickets;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text("WaitListed Tickets"),
      ),
      body: ListView.builder(
        itemCount: listOfWaitListsTickets.length,
        itemBuilder: (context,index)=>
      WaitListCard(ticket: listOfWaitListsTickets[index])),
    );
  }

}