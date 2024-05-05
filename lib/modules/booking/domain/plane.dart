// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Plane {
  Plane( {required this.id, this.name,this.airCraftType, this.prev_maintanance, this.next_maintanance, this.num_bus, this.num_first, this.num_Eco});
  final String id;
  final String? airCraftType;
  // ignore: non_constant_identifier_names
  final DateTime? prev_maintanance;
  // ignore: non_constant_identifier_names
  final DateTime? next_maintanance;
  // ignore: non_constant_identifier_names
  final int? num_bus;
  // ignore: non_constant_identifier_names
  final int? num_first;
  // ignore: non_constant_identifier_names
  final int? num_Eco;
  final String? name;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'airCraftType': airCraftType,
      'prev_maintanance': prev_maintanance,
      'next_maintanance': next_maintanance,
      'num_bus': num_bus,
      'num_first': num_first,
      'num_Eco': num_Eco,
      "name":name
    };
  }

  factory Plane.fromMap(Map<String, dynamic> map) {
    return Plane(
      id: map['id'] ,
      airCraftType: map['Aircraft Type'],
      prev_maintanance: DateTime.parse(map['prev_maintanance']),
      next_maintanance: DateTime.parse(map['next_maintanance']),
      num_bus: map['num_bus'] ,
      num_first: map['num_first'] ,
      num_Eco: map['num_Eco'] ,
      name: map["name"]
    );
  }

  String toJson() => json.encode(toMap());

  factory Plane.fromJson(String source) => Plane.fromMap(json.decode(source) as Map<String, dynamic>);
}
