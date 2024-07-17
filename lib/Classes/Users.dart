// ignore: file_names
class Users
{
   String? token;
   int? id;
   int? rolid;
   String? name;
   String? logo;
   String? companyname;
   String? email;

   Users({this.companyname,this.id,this.name,this.logo,this.token,this.rolid,this.email});



   factory Users.fromJson(Map<String, dynamic> parsedJson) {
    // ignore: unnecessary_new
    return new Users(
      name: parsedJson['name'] ?? "",
      email: parsedJson['email'] ?? "",
      token: parsedJson['token'] ?? "",
      id: parsedJson['id'] ?? "",
      rolid: parsedJson['rolid'] ?? "",
      logo: parsedJson['logo'] ?? "",
      companyname: parsedJson['companyname'] ?? "");
  }
        
  Map<String, dynamic> toJson() 
  {
    return {
      "id": id,
      "email": email,
      "rolid": rolid,
      "name": name,
      "logo": logo,
      "token": token,
      "companyname": companyname

    };

 
}
}