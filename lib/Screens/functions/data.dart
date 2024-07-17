import '../../Classes/Users.dart';
import '../../Services/globals.dart';
import 'globaldata.dart';

Future<String?> getUserToken() async {
  Users? users;
  final sessionData = await getSessionData();

  users = Users(
    id: sessionData.id,
    rolid: sessionData.rolid,
    name: sessionData.name,
    logo: sessionData.logo,
    companyname: sessionData.companyname,
    token: sessionData.token,
  );
  return users.token;
}

Future<String?> getUserId() async {
  Users? users;
  final sessionData = await getSessionData();

  users = Users(
    id: sessionData.id,
    rolid: sessionData.rolid,
    name: sessionData.name,
    logo: sessionData.logo,
    companyname: sessionData.companyname,
    token: sessionData.token,
  );
  return users.id.toString();
}


Future<Users> getUserAllData() async {
  Users? users;
  final sessionData = await getSessionData();

  users = Users(
    id: sessionData.id,
    rolid: sessionData.rolid,
    name: sessionData.name,
    email: sessionData.email,
    logo: sessionData.logo,
    companyname: sessionData.companyname,
    token: sessionData.token,
  );
  return users;
}

converheadertoken() async {
  var token = await getUserToken();

  Map<String, String> headersToken = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Authorization': "Bearer " + token.toString(),
  };
  return headersToken;
}


getImagePath(path)
{
  String sonuc= siteurl+path;
  return sonuc;
}