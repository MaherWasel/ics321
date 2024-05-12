import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ics321/shared/models/plane.dart';

class AdminPlaneCard extends StatelessWidget{
  final List<Plane> listOfPlanes ;

  const AdminPlaneCard({super.key, required this.listOfPlanes});
  getFormatedDate(DateTime _date, bool time) {

    if (time){
    return DateFormat.jms().format(_date);
     

    }
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date);

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text("${listOfPlanes.length} Total Planes"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: listOfPlanes.length,
        itemBuilder: (context,index)=>
        Card(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FontAwesomeIcons.plane),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listOfPlanes[index].name.toString()),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.calendar_month),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Previes Maintanance"),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getFormatedDate(listOfPlanes[index].prev_maintanance!, false)),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.calendar_month),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Next Maintanance"),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getFormatedDate(listOfPlanes[index].next_maintanance!, false)),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FontAwesomeIcons.businessTime),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Maximum Business Seats"),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listOfPlanes[index].num_bus!.toString()),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FontAwesomeIcons.award),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Maximum Business Seats"),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listOfPlanes[index].num_first!.toString()),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FontAwesomeIcons.star),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Maximum Economy Seats"),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listOfPlanes[index].num_Eco!.toString()),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.flight),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Number Of Flights"),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listOfPlanes[index].numOfFlights.toString()),
                  )
                ],
              ),
               Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.airplane_ticket),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Number Of Reserved Tickets"),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listOfPlanes[index].numOfBookedSeast.toString()),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.calculate),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Average Load Factor"),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(((listOfPlanes[index].numOfBookedSeast)/(listOfPlanes[index].numOfFlights*(listOfPlanes[index].num_Eco!+
                    listOfPlanes[index].num_bus!+listOfPlanes[index].num_first!))).toStringAsFixed(5)),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }

}