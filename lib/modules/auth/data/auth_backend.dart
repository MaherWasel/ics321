import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/shared/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AuthBackEnd{
 
  Future<UserModel?> authenticateUser({required String id , String? name, String? phoneNumber, String? email})async{
    final response =await Supabase.instance.client.from("User").select().filter("id", 'eq', UuidValue.fromString(id).toFormattedString());

    if (response.isEmpty){
      await Supabase.instance.client.from("User").insert(
      { 'id': UuidValue.fromString(id).toFormattedString(), 'name': name, 'phone': phoneNumber });
      return UserModel(id: id,name: name,phone: phoneNumber);
    }
   
    return UserModel.fromJson(response[0]);
  }
}