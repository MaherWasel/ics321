import 'package:supabase_flutter/supabase_flutter.dart';

void main ()async {
  final list= ["First","Business","Economy"];
  String id="ba0adaa4-e11d-4074-8dd6-5fd87fa7d41d";
  await Supabase.initialize(
    url: 'https://vlnrnqnzdsmjtpxhvivi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZsbnJucW56ZHNtanRweGh2aXZpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ3MTgxNzcsImV4cCI6MjAzMDI5NDE3N30.Xb27CtuPD31ihBhs4-otSgtc6Ed_r4CgHFLV0I70B4I',
  );
  for (int i=1;i<201;i++){
    
    await Supabase.instance.client.from("Seat").insert({"flight_id":id,"location":"A$i","type":"Economy"});

  }
  for (int i=1;i<61;i++){
    
    await Supabase.instance.client.from("Seat").insert({"flight_id":id,"location":"C$i","type":"First"});

  }
  for (int i=1;i<81;i++){
    
    await Supabase.instance.client.from("Seat").insert({"flight_id":id,"location":"B$i","type":"Business"});

  }

}