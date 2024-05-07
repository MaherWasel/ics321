import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/shared/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AuthBackEnd{
 
  Future<UserModel?> authenticateUser({required String id , String? name, String? phoneNumber, String? email})async{
    final response =await Supabase.instance.client.from("User").select().filter("id", 'eq', UuidValue.fromString(id).toFormattedString());
    final adminResponse=await Supabase.instance.client.from("Admin").select().eq("id", UuidValue.fromString(id).toFormattedString());
    final isAdmin = adminResponse.isNotEmpty;
    if (response.isEmpty){
      
      await Supabase.instance.client.from("User").insert(
      { 'id': UuidValue.fromString(id).toFormattedString(), 'name': name, 'phone': phoneNumber });
      final user=UserModel(id: id,name: name,phone: phoneNumber,isAdmin: isAdmin);
      Utils.user=user;
      return user;
    }
   final user=UserModel.fromJson(response[0]);
   user.isAdmin=isAdmin;
   print("maher");
   print(isAdmin);
   Utils.user=user;
    return user;
  }
}