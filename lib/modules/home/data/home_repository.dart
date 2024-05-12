import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/shared/models/flight.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid_value.dart';

class HomeRepository{
  Future<List<FlightModel>> getAllFlights()async {
    await Future.delayed(Duration(seconds: 1));
    final response =await Supabase.instance.client.from("Flight").select();
    final List<FlightModel> listOfFlighs=[];
    for (int i=0;i<response.length;i++){
      listOfFlighs.add(FlightModel.fromMap(response[i]));
    }
    return listOfFlighs;

  }
  Future<void> updateUserInfo({required String? email,required String? name})async{
    await Supabase.instance.client.from("User").update({"email":email,"name":name}).filter("id", 'eq', UuidValue.fromString(Utils.user!.id).toFormattedString());

  }
  List<FlightModel> filterFlights({required List<FlightModel> listOfFlights, DateTime? date,String? source,String? destination}){
    listOfFlights=listOfFlights.where((e) => e.date.isAfter(DateTime.now())).toList();
    if (date ==null && source ==null && destination ==null){
      return listOfFlights;
    }
    else if (date ==null &&source !=null&&destination==null){
      return listOfFlights.where((element) => element.source==source).toList();
    }
    else if (date ==null &&source !=null&&destination!=null){
      return listOfFlights.where((element) => element.source==source&&element.destination==destination).toList();

    }
    else if (date!=null &&source==null&&destination==null){
      return listOfFlights.where((element) => element.date.isAtSameMomentAs(date)).toList();

    }
    else if (date!=null &&source!=null&&destination==null){
      return listOfFlights.where((element) => element.date.isAtSameMomentAs(date)&&element.source==source).toList();

    }
    else if (date!=null &&source!=null&&destination!=null){
      return listOfFlights.where((element) => element.date.isAtSameMomentAs(date)&&element.source==source&&element.destination==destination).toList();

    }
    else if (date==null &&source==null&&destination!=null){
      return listOfFlights.where((element) => element.destination==destination).toList();

    }
    else  {
      return listOfFlights.where((element) => element.destination==destination && element.date.isAtSameMomentAs(date!)).toList();

    }


    }

  
  
}
