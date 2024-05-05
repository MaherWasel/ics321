import 'package:ics321/modules/booking/domain/plane.dart';
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

}