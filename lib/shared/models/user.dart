class UserModel {
  final String id;
   String? name;
   String? phone;
   String? email;
   bool? isAdmin;
  UserModel( {required this.id,this.name,this.phone, this.email ,this.isAdmin=false});

  UserModel.fromJson(Map<String, dynamic>json)
      : id = json['id'] ,
        name = json['name'] ??"" ,
        phone=json["phone"] ?? "",
        email=json["email"];
        


        
        


  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        "phone":phone
      };
}