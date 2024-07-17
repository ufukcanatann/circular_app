
import 'package:http/http.dart' as http;

import '../Screens/functions/data.dart';
import 'globals.dart';

class GetServices {
  static Future<http.Response> getNotificationList(userid, int tur) async {

        var newtoken = await converheadertoken();

    var url = Uri.parse(
        "${baseURL}notifications/$userid/$tur");
    //var url=Uri.parse("http://192.168.1.53:80/api/notifications/1");
    var response = await http.get(
      url,
      headers: newtoken,
    );
    return response;
  }

  static Future<http.Response> getCarList(int type) async
  {
    var userid = await getUserId();
    var newtoken = await converheadertoken();

    var url = Uri.parse(
        "${baseURL}getcarlist/$userid/$type");
    var response = await http.get(
      url,
      headers: newtoken,
    );

    return response;
  }


  static Future<http.Response> getProdcuts() async 
    {
      var userid = await getUserId();
        var newtoken = await converheadertoken();

      var url = Uri.parse(
          "${baseURL}getproducts/$userid");
      var response = await http.get(
        url,
        headers: newtoken,
      );

      return response;
    }

  static Future<http.Response> getmydrives() async 
  {
      var userid = await getUserId();
      var newtoken = await converheadertoken();
      var url = Uri.parse(
          "${baseURL}yolculuklistesinigetir/$userid");
      var response = await http.get(
        url,
        headers: newtoken,
      );
      return response;
    }

  static Future<http.Response> yolculukBilgileriniGetir(rideid) async 
  {
      var userid = await getUserId();
      var newtoken = await converheadertoken();
      var url = Uri.parse(
          "${baseURL}yolculukBilgileriniGetir/$userid/$rideid");
      var response = await http.get(
        url,
        headers: newtoken,
      );
      return response;
    }

  static Future<http.Response> getUserInfo() async 
  {
    var userid = await getUserId();
    var newtoken = await converheadertoken();
    
    var url = Uri.parse(
        "${baseURL}getuserinfo/$userid");
    var response = await http.get(
      url,
      headers: newtoken,
    );

    return response;
  }


static Future<http.Response> getStateList() async 
{
    var newtoken = await converheadertoken();
    
    var url = Uri.parse(
        "${baseURL}getstates");
    var response = await http.get(
      url,
      headers: newtoken,
    );
    return response;
  }  
  static Future<http.Response> butunSurucListesi() async 
{
    var newtoken = await converheadertoken();
    var userid = await getUserId();

    var url = Uri.parse(
        "${baseURL}butunSurucListesi/"+userid.toString());
    var response = await http.get(
      url,
      headers: newtoken,
    );
    return response;
  }

}





