import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Screens/functions/data.dart';
import 'globals.dart';

class PostServices
{
   static Future<http.Response> saveCareLocation(
      double enlem, double boylam, int carid,desc) async 
     {
        Map data = {"enlem": enlem, "boylam": boylam, "carid": carid,"desc":desc};
        var newtoken = await converheadertoken();
        var body = json.encode(data);
        var url = Uri.parse('${baseURL}savecarlocationdata');
        var response = await http.post(
          url,
          headers: newtoken,
          body: body,
        );
        return response;
   }

  static Future<http.Response> changePassword(String password) async
  {
    var userid = await getUserId();
    Map data = {"password": password,"userid": userid};
    var newtoken = await converheadertoken();
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}changePassword');
    var response = await http.post(
      url,
      headers: newtoken,
      body: body,
    );
    return response;
  }

   static Future<http.Response> yolculukpaylaspost(carid, enlem,boylam,comment,nereden,nereye,rota,kapasite,trh) async
  {
    //sürücünün yolculuk paylaşması
    //var userid = await getUserId();
    Map data = {"carid": carid,"enlem": enlem,"boylam": boylam,"comment": comment,"nereden":nereden,"nereye":nereye,"rota":rota,"kapasite":kapasite,"yolcularbaslamasaati":trh.toString()};
    var newtoken = await converheadertoken();
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}yolculukpaylaspost');
    var response = await http.post(
      url,
      headers: newtoken,
      body: body,
    );
    return response;
  }

  static Future<http.Response> yolculuktalebigonder(rideid) async
  {
    //yolculuk talebi göndermek

    var userid = await getUserId();
    Map data = {"rideid": rideid,"userid": userid};
    var newtoken = await converheadertoken();
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}yolculuktalebigonder');
    var response = await http.post(
      url,
      headers: newtoken,
      body: body,
    );
    return response;
  }

  // static Future<http.Response> endajourney(int carid,double enlem,double boylam) async
  // {
  //   //müşterinin yolcuğu başlatması
  //   var userid = await getUserId();
  //   Map data = {"carid": carid,"enlem": enlem,"boylam": boylam,"userid": userid};
  //   var newtoken = await converheadertoken();
  //   var body = json.encode(data);
  //   var url = Uri.parse('${baseURL}endajourney');
  //   var response = await http.post(
  //     url,
  //     headers: newtoken,
  //     body: body,
  //   );
  //   return response;
  // }

  static Future<http.Response> surucuyeyildizver(ayid,comment,point) async
  {
      Map data = {"ayid": ayid.toString(),"point": point.toString(),"comment":comment.toString()};
      var newtoken = await converheadertoken();
      var body = json.encode(data);
      var url = Uri.parse('${baseURL}yolcuyaPuanYorumEkleme');
      var response = await http.post(
        url,
        headers: newtoken,
        body: body,
      );
      return response;
  }


  static Future<http.Response> aracFiltrele(nereden, nereye,tarih) async
  {
    //sürücünün yolculuk paylaşması
   var userid = await getUserId();
    Map data = {"nereden":nereden,"nereye":nereye,"tarih":tarih,"userid":userid};
    var newtoken = await converheadertoken();
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}searchCar');
    var response = await http.post(
      url,
      headers: newtoken,
      body: body,
    );
    return response;
  }
  

  static Future<http.Response> yolcudurumdegistirme(rideid,type,enlem,boylam,{ userid = "0"}) async
  {
    //sürücünün yolculuk paylaşması
    if(userid=="0")
    {
         userid = await getUserId();
    }
    Map data = {"rideid":rideid,"status":type,"userid":userid,"enlem":enlem,"boylam":boylam};
    
    var newtoken = await converheadertoken();
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}yolcudurumdegistirme');
    var response = await http.post(
      url,
      headers: newtoken,
      body: body,
    );
    return response;
  }

  static Future<http.Response> hesabimisil() async
  {
        var userid = await getUserId();

      Map data = {"userid": userid.toString()};
      var newtoken = await converheadertoken();
      var body = json.encode(data);
      var url = Uri.parse('${baseURL}hesabimisil');
      var response = await http.post(
        url,
        headers: newtoken,
        body: body,
      );
      return response;
  }
  
}

