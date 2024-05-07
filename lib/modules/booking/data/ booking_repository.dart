import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/booking/domain/plane.dart';
import 'package:ics321/modules/booking/domain/seat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class BookingRepository{
  Future<Plane?> getPlane({required String planeId})async {
    final response= await Supabase.instance.client.from("Plane").select();
    print(response);
    if (response.isEmpty){
      return null;
    }
    return Plane.fromMap(response[0]);
  }
  Future<List<Seat>> getAvailableSeats({required String flight_id, String? status,String? type})async{
    final response = await Supabase.instance.client.from("Seat").select().
    filter("flight_id", 'eq', flight_id,);
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
  Future<void> sendTicket({required String flight_id,required double price,required String seatLocation})async {

    await Supabase.instance.client.from("Ticket").insert(
      {"flight_id":flight_id,
      "price":price,
      "seat_location":seatLocation,
      "user_id":UuidValue.fromString(Utils.userId).toFormattedString()}
      );
    await Supabase.instance.client.from("Seat").update({"status":"Reserved"}).eq("location", seatLocation).eq("flight_id", flight_id);
  }

}