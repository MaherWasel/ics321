import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ics321/shared/models/flight.dart';

class AdminDateReport extends StatelessWidget{
  final List<FlightModel> listOfFligts;

  const AdminDateReport({super.key, required this.listOfFligts});
  getFormatedDate(DateTime _date, bool time) {

    if (time){
    return DateFormat.jms().format(_date);
     

    }
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date);

    }
  @override
  Widget build(BuildContext context) {
    double totalNumOfBooks=0;
    for (int i=0;i<listOfFligts.length;i++){
      totalNumOfBooks+=listOfFligts[i].numOfBooked!;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title:Text(totalNumOfBooks.toString()+" Booked Tickets"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: listOfFligts.length,
        itemBuilder: (context,index){
          return Card(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.flight_takeoff),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(listOfFligts[index].source),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.flight_land),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(listOfFligts[index].destination),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.calendar_month),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(getFormatedDate(listOfFligts[index].date,false)),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.schedule),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(getFormatedDate(listOfFligts[index].time,true)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("number of booked tickets"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(listOfFligts[index].numOfBooked.toString()),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.percent),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text((listOfFligts[index].numOfBooked!/totalNumOfBooks*100).toStringAsFixed(2)),
                    )
                  ],
                )
                ],
            ),
          );
        }),
    );
  }

}