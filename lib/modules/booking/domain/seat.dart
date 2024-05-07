// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Seat {
  final String location;
  final String flightId;
  final String type;
  final String? status;
  Seat({required  this.location, required this.flightId, required this.type, this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'flightId': flightId,
      'type': type,
      'status': status,
    };
  }

  factory Seat.fromMap(Map<String, dynamic> map) {
    return Seat(
      location: map['location'] ,
      flightId: map['flight_id'],
      type: map['type'] ,
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Seat.fromJson(String source) => Seat.fromMap(json.decode(source) as Map<String, dynamic>);
}
