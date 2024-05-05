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
  FlightModel({
    required this.id,
    required this.date,
    required this.source,
    required this.destination,
    required this.time,
    required this.planeId
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
      date: DateTime.parse(map["date"]),

      source: map['source'] ,
      destination: map['destination'] ,
      time: DateTime.parse(map["date"]+" "+map['time']),
      
      planeId:map["plane_id"],
    );
  }



  factory FlightModel.fromJson(String source) => FlightModel.fromMap(json.decode(source) as Map<String, dynamic>);
}