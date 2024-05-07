// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ics321/shared/models/flight.dart';

class Ticket {
  final String id;
  final FlightModel? flight;
  final double? price;
  final String? status;
  final String? seat_location;
  final String? user_id;
  Ticket({required this.id, this.flight, this.price, this.status, this.seat_location, this.user_id});

}