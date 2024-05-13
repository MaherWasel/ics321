import 'package:ics321/modules/booking/domain/seat.dart';
import 'package:ics321/shared/models/ticket.dart';
import 'package:ics321/shared/models/flight.dart';
import 'package:ics321/shared/models/plane.dart';
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
        user_id: response[i]["user_id"],
        class_type: response[i]["class_type"]
        ));
    }

    return list;
  }
  Future<List<Seat>> getAvailableSeats({required String flight_id, String? status,String? type,required String class_type})async{
    final response = await Supabase.instance.client.from("Seat").select().
    filter("flight_id", 'eq', flight_id,).eq("type", class_type);
        List<Seat> list=[];
        for (int i=0;i<response.length;i++){

            list.add(Seat.fromMap(response[i]));
    } 
        if (type !=null){
          list=list.where((element) => element.type==type).toList();
        }
         if (status !=null){
          list=list.where((element) => element.status==status).toList();
        }
         if (type !=null && status!=null){
          list=list.where((element) => element.type==type&&element.status==status).toList();

        }
         if (status==null){
          list=list.where((element) => element.status==null).toList();
        }


        return list;
    

  }
  Future<void> changeWaitList({required Ticket ticketId ,required String seatLocation})async {
    await Supabase.instance.client.from("Ticket").update({"status":"not paid","seat_location":seatLocation}).eq("id", ticketId.id);
    await Supabase.instance.client.from("Seat").update({"status":"Reserved"}).eq("flight_id", ticketId.flight!.id).eq("location", seatLocation);
  }
  Future<void> cancelTicket({required Ticket ticket})async{
    await Supabase.instance.client.from("Ticket").update({"status":"Cancelled"}).eq("flight_id", ticket.flight!.id).eq('user_id', ticket.user_id!).eq("seat_location", ticket.seat_location!);
    await Supabase.instance.client.from("Seat").update({"status":null}).eq('flight_id', ticket.flight!.id).eq('location', ticket.seat_location!);
    if (ticket.status=="paid"){
      await Supabase.instance.client.from("Payment").insert({"method":"Credit Card",'amount':ticket.price,"user_id":ticket.user_id,"status":"Refund","ticket_id":ticket.id});
    }
    
  }
  Future<Plane?> getPlane({required String planeId})async {
    final response= await Supabase.instance.client.from("Plane").select().eq('id', planeId);

    if (response.isEmpty){
      return null;
    }
    return Plane.fromMap(response[0]);
  }
  Future<void> payTicket({required Ticket ticketId,required String user_id})async{
    await Supabase.instance.client.from("Ticket").update({"status":"paid"}).eq("id", ticketId.id).eq("user_id", user_id);
    await Supabase.instance.client.from("Payment").insert({"user_id":user_id,"status":"paid","method":"Credit Card","amount":ticketId.price,"ticket_id":ticketId.id});
  }
}