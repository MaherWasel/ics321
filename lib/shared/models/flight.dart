// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class FlightModel {
  final String id;
  final DateTime date;
  final String source;
  final String destination;
  final DateTime time;
  final String planeId;
  final double? economy_price;
  final double? business_price;
  final double? first_price;
  double? numOfBooked;
  FlightModel( {
    required this.economy_price, required this.business_price,required  this.first_price,
    required this.id,
    required this.date,
    required this.source,
    required this.destination,
    required this.time,
    required this.planeId,
    this.numOfBooked=0.0

  });
  // Map<String, dynamic> toJson() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'date': "date.millisecondsSinceEpoch",
  //     'source': source,
  //     'destination': destination,
  //     'time': time.millisecondsSinceEpoch,
  //     'planeId': planeId,
  //   };
  // }

// 2012-02-27 13:27:00.000
  factory FlightModel.fromMap(Map<String, dynamic> map) {
    return FlightModel(
      id:  map["id"],
      first_price:map["first_price"]*1.0,
      business_price:map["business_price"]*1.0,
      economy_price:map["economy_price"]*1.0 ,
      date: DateTime.parse(map["date"]),

      source: map['source'] ,
      destination: map['destination'] ,
      time: DateTime.parse(map["date"]+" "+map['time']),
      
      planeId:map["plane_id"],

    );
  }



  factory FlightModel.fromJson(String source) => FlightModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
