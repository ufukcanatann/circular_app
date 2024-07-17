import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circularmindapp/Screens/mydrives.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Services/globals.dart';
import '../../main.dart';
import '../MyCars.dart';
import '../products.dart';
import 'data.dart';
import 'mapfunctions.dart';

notification(context, message) {
  if (Platform.isIOS) {
    // return Container();
  }
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
  );
}

loadingbar() {
  return Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

drawer(context, userData) {
  return Drawer(
    child: Container(
      alignment: Alignment.center,
      color: themaColor(),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,

        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFF5283C1),
                    ),
                    accountName: Text(
                      userData.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themaColor(),
                          fontSize: 20,
                          height: 1),
                    ),
                    accountEmail: Container(
                      child: Text(
                        userData.email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themaColor(),
                        ),
                      ),
                    ),
                    currentAccountPicture: FadeInImage(
                      placeholder: AssetImage('assets/images/profile.png'),
                      image: NetworkImage(getImagePath(userData.logo)),
                      fit: BoxFit.fill,
                    )),
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.directions_car_filled_outlined,
              color: ikonColor(),
            ),
            title: Text(
              "Araçlarım",
              style: TextStyle(
                color: ikonColor(),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCars()),
              );
              //Araçlar Sayfası
            },
          ),
          ListTile(
            leading: Icon(
              Icons.published_with_changes_outlined,
              color: ikonColor(),
            ),
            title: Text(
              "Sürüşlerim",
              style: TextStyle(
                color: ikonColor(), // Metin rengini burada belirleyebilirsiniz
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyDrivesPage()),
              );
              //Araçlar Sayfası
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_basket_outlined,
              color: ikonColor(),
            ),
            title: Text(
              "Vitrin",
              style: TextStyle(
                color: ikonColor(), // Metin rengini burada belirleyebilirsiniz
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductPage()),
              );
              //Araçlar Sayfası
            },
          ),
          ListTile(
            leading: Icon(
              Icons.question_mark_rounded,
              color: ikonColor(),
            ),
            title: Text(
              "Nasıl Kullanırım?",
              style: TextStyle(
                color: ikonColor(), // Metin rengini burada belirleyebilirsiniz
              ),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MyCarList()),
              // );
              //Araçlar Sayfası
            },
          ),
          ListTile(
            leading: Icon(
              Icons.messenger_outline_outlined,
              color: ikonColor(),
            ),
            title: Text(
              "Bize Ulaşın",
              style: TextStyle(
                color: ikonColor(), // Metin rengini burada belirleyebilirsiniz
              ),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MyCarList()),
              // );
              //Araçlar Sayfası
            },
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer_outlined,
              color: ikonColor(),
            ),
            title: Text(
              "Sıkça Sorulan Sorular",
              style: TextStyle(
                color: ikonColor(), // Metin rengini burada belirleyebilirsiniz
              ),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MyCarList()),
              // );
              //Araçlar Sayfası
            },
          ),
          AboutListTile(
            // <-- SEE HERE
            icon: Icon(
              Icons.info_outline,
              color: ikonColor(),
            ),
            child: Text(
              'Hakkında',
              style: TextStyle(
                color: ikonColor(), // Metin rengini burada belirleyebilirsiniz
              ),
            ),
            applicationName: 'Circular Mind',
            applicationVersion: '1.0.25',
            applicationLegalese: '© 2023',
            aboutBoxChildren: [
              ///Content goes here...
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: ikonColor(),
            ),
            title: Text(
              'Çıkış Yap',
              style: TextStyle(
                color: ikonColor(), // Metin rengini burada belirleyebilirsiniz
              ),
            ),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ],
      ),
    ),
  );
}

activitycart(title1, desc, path) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Title'ı sola hizalar
        children: [
          Image.network(path), // Görseli üste taşıdık

          Padding(
            padding: EdgeInsets.only(left: 10, top: 5, right: 5, bottom: 5),
            child: Text(
              title1,
              style: TextStyle(
                color: Color(0xFF4C84C4),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 0, right: 10, left: 10, bottom: 10),
            child: Text(
              desc,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    ),
  );
}

carModalDetail(element, context, gelenrideid) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
          width: 400,
          height: 283,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0x331D1D1D)),
              borderRadius: BorderRadius.circular(25),
            ),
            shadows: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Container(
            width: 380,
            height: 242,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 380,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 57,
                        height: 46,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 2,
                              child: Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/fiesta.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 162,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              element["marka"].toString() +
                                  " " +
                                  element['model'].toString(),
                              style: TextStyle(
                                color: Color(0xFF1D1D1D),
                                fontSize: 20,
                                fontFamily: 'Inria Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Text(
                              element['plaka'].toString(),
                              style: TextStyle(
                                color: Color(0xFF7D7D7D),
                                fontSize: 16,
                                fontFamily: 'Inria Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          var sonuc =
                              await yolculuktalebiolustur(gelenrideid, context);
                          var ara = json.decode(sonuc.body);
                          if (ara['status'] == 0) {
                            notification(context, ara['mesaj'].toString());
                          } else {
                            notification(context, ara['mesaj'].toString());
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyDrivesPage()));
                          }
                          /*if (sonuc['status'].toString() == "0") {
                            notification(context, sonuc['mesaj']);
                          } else if (sonuc['status'].toString() == "1") {
                            notification(context, sonuc['mesaj']);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyDrivesPage()));

                          }*/
                        },
                        child: SizedBox(
                          width: 135,
                          child: Text(
                            'Yolculuk Talep Et',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF5283C1),
                              fontSize: 15,
                              fontFamily: 'Inria Sans',
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              height: 0.08,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 380,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black.withOpacity(0.10000000149011612),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 95,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '10 Ocak 2024',
                              style: TextStyle(
                                color: Color(0xFF1D1D1D),
                                fontSize: 14,
                                fontFamily: 'Inria Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Text(
                              '19:15 - 19:41',
                              style: TextStyle(
                                color: Color(0xFF7D7D7D),
                                fontSize: 12,
                                fontFamily: 'Inria Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 115,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Güzergah',
                              style: TextStyle(
                                color: Color(0xFF1D1D1D),
                                fontSize: 14,
                                fontFamily: 'Inria Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Text(
                              'Beylikdüzü - Florya',
                              style: TextStyle(
                                color: Color(0xFF7D7D7D),
                                fontSize: 12,
                                fontFamily: 'Inria Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 70,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Puan',
                              style: TextStyle(
                                color: Color(0xFF1D1D1D),
                                fontSize: 14,
                                fontFamily: 'Inria Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Text(
                              element['score'].toString(),
                              style: TextStyle(
                                color: Color(0xFF7D7D7D),
                                fontSize: 12,
                                fontFamily: 'Inria Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 70,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Kapasite',
                              style: TextStyle(
                                color: Color(0xFF1D1D1D),
                                fontSize: 14,
                                fontFamily: 'Inria Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Text(
                              '3/5 Kişi',
                              style: TextStyle(
                                color: Color(0xFF7D7D7D),
                                fontSize: 12,
                                fontFamily: 'Inria Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 380,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black.withOpacity(0.10000000149011612),
                      ),
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.10000000149011612),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 5),
                      Icon(
                        Icons.place,
                        color: Color(0xFF333333),
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Mecidiyeköy Meydan Yönü, Cevahir AVM Arkası',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 14,
                          fontFamily: 'Inria Sans',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 380,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 5),
                      Icon(
                        Icons.place,
                        color: Color(0xFF5CB85C),
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Yol Tarifi Al',
                        style: TextStyle(
                          color: Color(0xFF5CB85C),
                          fontSize: 14,
                          fontFamily: 'Inria Sans',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));

      // return Container(
      //   width: MediaQuery.of(context).size.width,
      //   height: MediaQuery.of(context).size.height * 5,
      //   decoration: BoxDecoration(
      //     color: Color(0xFF142850),
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(30),
      //       topRight: Radius.circular(30),
      //     ),
      //   ),
      //   child: SingleChildScrollView(
      //     child: Container(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           cardModalPlates(element, context, 1,gelenrideid),
      //           cardModalDescription(element, context,gelenrideid),
      //         ],
      //       ),
      //     ),
      //   ),

      // );
    },
  );
}

cardModalPlates(element, context, int s, gelenrideid) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Transform.translate(
        offset: Offset(screenWidth * 0.01,
            -50.0), // Yukarıya -35px ve soldan -35px kaydırır
        child: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      Column(
        children: [
          Container(
            width: screenWidth * 0.3,
            height: screenHeight * 0.15,
            child: FittedBox(
              fit: BoxFit.cover, // Görseli tam kutunun içine sığdırır
              child: Image.asset("assets/images/fiesta.png"),
            ),
          ),
          Text(
            element["marka"] + " " + element['model'],
            style: TextStyle(
              fontSize: 25, // Font boyutunu 25px yapar
              color: Colors.white, // Metin rengini beyaz yapar
            ),
          ),
          Text(
            element['plaka'].toString(),
            style: TextStyle(
              fontSize: 15, // Font boyutunu 15px yapar
              color: Colors.white, // Metin rengini beyaz yapar
            ),
          ),
          InkWell(
            onTap: () async {
              var sonuc = await yolculuktalebiolustur(gelenrideid, context);
              var ara = json.decode(sonuc.body);
              if (ara['status'] == 0) {
                notification(context, ara['mesaj'].toString());
              } else {
                notification(context, ara['mesaj'].toString());
              }
              if (sonuc['status'].toString() == "0") {
                notification(context, sonuc['mesaj']);
              } else if (sonuc['status'].toString() == "1") {
                notification(context, sonuc['mesaj']);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyDrivesPage()));
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: 10), // Yukarıya 10px margin ekler
              padding: EdgeInsets.all(10.0), // 10px iç boşluk ekler
              decoration: BoxDecoration(
                color: Color(0xFF5283C1), // Arkaplan rengini FF4545 yapar
                borderRadius: BorderRadius.circular(
                    15.0), // Köşeleri 15px yarıçapında yuvarlar
              ),
              child: Text(
                "TALEP ET",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15, // Font boyutunu 15px yapar
                  color: Color(0xFF142850), // Metin rengini 142850 yapar
                ),
              ),
            ),
          )
        ],
      ),
      Transform.translate(
        offset: Offset(-20.0, -50.0), // Yukarıya -35px ve soldan -35px kaydırır
        child: Container(
          child: IconButton(
            icon: Icon(Icons.info_outline_rounded),
            color: Colors.white,
            onPressed: () {
              carModalInfo(element,
                  context); // IconButton'a tıklandığında yapılacak işlemler burada tanımlanır
            },
          ),
        ),
      ),
    ],
  );
}

cardModalDescription(element, context, gelenrideid) {
  double screenWidth = MediaQuery.of(context).size.width;
  double iconSize = MediaQuery.of(context).size.width * 0.07;
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 10, // Birinci Container'ı 2 oranında genişletir
          child: Container(
              child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    right:
                        8.0), // İstediğiniz padding değerlerini ayarlayabilirsiniz
                child: SvgPicture.asset(
                  'assets/images/icons/location-dot-solid.svg',
                  width: iconSize,
                  height: iconSize,
                  color: ikonColor(),
                ),
              ),
              Container(
                width: screenWidth * 0.45, // Genişliği ayarlayın
                child: Text(
                  element['desc'].toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )),
        ),
        Expanded(child: Container(), flex: 1),
        Expanded(
          flex: 5, // İkinci Container'ı 1 oranında genişletir
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Telefon numarası
                    String phoneNumber = element['phone_number']
                        .toString(); // Telefon numarasını ekleyin

                    // Telefonu ara
                    // ignore: deprecated_member_use
                    launch("tel:$phoneNumber");
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                            right:
                                8.0), // İstediğiniz padding değerlerini ayarlayabilirsiniz
                        child: SvgPicture.asset(
                          'assets/images/icons/phone.svg',
                          width: iconSize,
                          height: iconSize,
                          color: ikonColor(),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Buraya tıklama işlemini ekleyebilirsiniz.
                        },
                        child: Text(
                          "Ara",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // WhatsApp numarası
                    String phoneNumber = element['phone_number']
                        .toString(); // Telefon numarasını ekleyin
                    // Mesaj
                    String message =
                        "Merhaba, buraya mesajınızı yazın."; // İstediğiniz mesajı ekleyin

                    // WhatsApp URL'si oluşturma
                    String whatsappUrl =
                        "https://wa.me/$phoneNumber?text=${Uri.parse(message)}";

                    // WhatsApp uygulamasını aç
                    // ignore: deprecated_member_use
                    launch(whatsappUrl);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: 8.0,
                          right: 8.0,
                        ),
                        child: SvgPicture.asset(
                          'assets/images/icons/whatsapp.svg',
                          width: iconSize,
                          height: iconSize,
                          color: ikonColor(),
                        ),
                      ),
                      Text(
                        "Mesaj",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

carModalInfo(element, context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width, // Ekranın genişliği kadar
        height: MediaQuery.of(context).size.height * 5,
        decoration: BoxDecoration(
          color: Color(0xFF142850),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Birinci Column'ı en sola, ikinci Column'ı en sağa yaslar
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: screenWidth *
                                0.1), // Sol taraftan 10 birim boşluk
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white, // Kenarlığın rengi
                              width: 2.0, // Kenarlık kalınlığı
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)), // 10 birim yuvarlak köşeler
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: screenWidth * 0.3,
                                height: screenHeight * 0.22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/profile.png'), // Profil fotoğrafı için uygun bir resim dosyası ekleyin
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                element['name'].toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        margin: EdgeInsets.only(
                            right: screenWidth *
                                0.1), // Sağ taraftan 10 birim boşluk
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Başlangıç noktalarını sabitler

                          children: [
                            lastcardItem(element['cinsiyet'].toString(),
                                "assets/images/icons/genderless-solid.svg"),
                            SizedBox(height: screenHeight * 0.03),
                            lastcardItem(element['puan'].toString(),
                                "assets/images/icons/star-solid.svg"),
                            SizedBox(height: screenHeight * 0.03),
                            lastcardItem(element['carid_count'].toString(),
                                "assets/images/icons/compass-solid.svg"),
                            SizedBox(height: screenHeight * 0.03),
                            lastcardItem(
                                element['formatted_created_at'].toString(),
                                "assets/images/icons/person-circle-plus-solid.svg"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

lastcardItem(text, path) {
  return Row(
    children: [
      SvgPicture.asset(
        path, // SVG dosyasının yolunu belirtin
        width: 32, // Genişlik ve yüksekliği ayarlayabilirsiniz
        height: 32,
        color: Colors.white,
      ),
      SizedBox(
          width: 8.0), // Görsel ile metin arasına biraz boşluk eklemek için
      Text(
        text.toString(),
        style: TextStyle(
          color: Colors.white,
        ),
      ), // Metin
    ],
  );
}
