import 'package:ics321/modules/my_tickets/domain/ticket.dart';
import 'package:ics321/shared/models/flight.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TicketRepository{
  Future<List<Ticket>> getTickets({required String userId})async {

    final response = await Supabase.instance.client.from("Ticket").select().eq('user_id', userId);

    final List<Ticket> list=[];
    for (int i=0;i<response.length;i++){

      final flightResponse = await Supabase.instance.client.from("Flight").select().eq("id", response[i]["flight_id"]);
      list.add(
        Ticket(id: response[i]["id"],
        flight: FlightModel.fromMap(flightResponse[0]),
        price: response[i]["price"]*1.0,
        status: response[i]["status"],
        seat_location: response[i]["seat_location"],
        user_id: response[i]["user_id"]
        ));
    }

    return list;
  }
}