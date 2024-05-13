
import 'package:ics321/shared/models/flight.dart';
import 'package:ics321/shared/models/plane.dart';
import 'package:ics321/shared/models/ticket.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminRepositroy{
  Future<List<FlightModel>> getFlights()async {

    final response = await Supabase.instance.client.from("Flight").select();

    final List<FlightModel> list=[];
    for (int i=0;i<response.length;i++){
      list.add(FlightModel.fromMap(response[i]));
    }

    return list;

  }
  Future<List<FlightModel>> getBookedPercentagesForFlights({required DateTime date})async {
    final response = await Supabase.instance.client.from("Flight").select();
    final List<FlightModel> filteredList=[];
    for (int i=0;i<response.length;i++){
      if (FlightModel.fromMap(response[i]).date.isAtSameMomentAs(date)){      
      filteredList.add(FlightModel.fromMap(response[i]));

      }
    }
    for (int i=0;i<filteredList.length;i++){
      final response = await Supabase.instance.client.from("Ticket").select().eq("flight_id", filteredList[i].id).not("status", 'eq', 'Cancelled').not("status", 'eq', 'waitList');
      filteredList[i].numOfBooked=response.length*1.0;
    }
    return filteredList;
  }
  Future<Plane?> getPlane({required String planeId})async {
    final response= await Supabase.instance.client.from("Plane").select().eq('id', planeId);

    if (response.isEmpty){
      return null;
    }
    return Plane.fromMap(response[0]);
  }
  Future<List<Plane>> getPlaneReports({required DateTime date})async {
    final response = await Supabase.instance.client.from("Flight").select();
    final List<FlightModel> filteredList=[];
    for (int i=0;i<response.length;i++){
      if (FlightModel.fromMap(response[i]).date.isAtSameMomentAs(date)){      
      filteredList.add(FlightModel.fromMap(response[i]));

      }
    }
    List<Plane> listOfPlanes =[];
    for (int i=0;i<filteredList.length;i++){
      final planeResponse = await Supabase.instance.client.from("Plane").select().eq("id", filteredList[i].planeId);
      final plane = Plane.fromMap(planeResponse[0]);
      if (!listOfPlanes.contains(plane)){
        final ticketReponse = await Supabase.instance.client.from("Ticket").select().eq("flight_id", filteredList[i].id).not("status", 'eq', 'Cancelled');
        plane.numOfBookedSeast+=ticketReponse.length*1.0;
        plane.numOfFlights+=1;
        listOfPlanes.add(plane);
      }
      else {
        for (int j=0;j<listOfPlanes.length;j++){
          if (plane==listOfPlanes[j]){
            final ticketReponse = await Supabase.instance.client.from("Ticket").select().eq("flight_id", filteredList[i].id).not("status", 'eq', 'Cancelled');
            listOfPlanes[j].numOfBookedSeast+=ticketReponse.length*1.0;
            listOfPlanes[j].numOfFlights+=1;
          }
        }
      }
    }
    return listOfPlanes;
  }
  Future<List<Ticket>> getTicketsForFlight({required FlightModel flight})async {
    final response=await Supabase.instance.client.from("Ticket").select().filter('flight_id', 'eq', flight.id);
    final List<Ticket> listOfTickets=[];
    for (int i=0;i<response.length;i++){
      listOfTickets.add(Ticket(id: response[i]["id"],flight: flight,price: response[i]["price"]*1.0,status: response[i]["status"],
      seat_location: response[i]['seat_location'],user_id: response[i]["user_id"]));
    }
    return listOfTickets;
  }
}