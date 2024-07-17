// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Classes/Users.dart';
import '../Services/post_services.dart';
import '../Services/get_services.dart';
import 'functions/data.dart';
import 'functions/widget.dart';
import 'login_screen.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  var kulaniciBilgisi;
  int? userid = 0;
  Users? users;
  bool isLoading = true;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  TextEditingController _sifrecontroller = TextEditingController();
  TextEditingController _sifretekrarcontroller = TextEditingController();
  String sifre = "";
  String sifretekrar = "";
  Color _backgroundColor = const Color(0x11333333);

  Future<dynamic> kulaniciBilgisigetir() async {
    var response = await GetServices.getUserInfo();
    setState(() {
      var ara = json.decode(response.body);

      kulaniciBilgisi = ara['data'];
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kulaniciBilgisigetir();
  }

  Widget build(BuildContext context) {
    var pageHeight = MediaQuery.of(context).size.height;
    var pageWidth = MediaQuery.of(context).size.width;
    if (isLoading) {
      return loadingbar();
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Profil",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: const Color(0xFF5283C1),
          toolbarHeight: 80,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: pageWidth * 0.3,
                          height: pageHeight * 0.12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                getImagePath(
                                    kulaniciBilgisi['avatar'].toString()),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              kulaniciBilgisi['name'].toString(),
                              style: const TextStyle(
                                  fontSize: 34, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              kulaniciBilgisi['companyname'].toString(),
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Color(0xFF5283C1),
                                  fontWeight: FontWeight.w300),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                _hesabimiSilButtonPressed(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5283C1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                              ),
                              child: const Text(
                                "Hesabımı Sil",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Inria Sans',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'KİŞİSEL BİLGİLER',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Divider(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'E-Mail:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Şirket:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kulaniciBilgisi['email'].toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                kulaniciBilgisi['companyname'].toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0x33333333),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 100,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '27',
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'YAŞ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0x33333333),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      kulaniciBilgisi['puan'].toString(),
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Text(
                                      'PUAN',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0x33333333),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      kulaniciBilgisi['cinsiyet'].toString(),
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Text(
                                      'CİNSİYET',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ŞİFRE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _sifrecontroller,
                          obscureText: !_isPasswordVisible,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            labelText: 'Şifre',
                            labelStyle: const TextStyle(
                              color: Color(0xaa333333),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                color: Color(0xAAFF4545),
                                width: 2.0,
                              ),
                            ),
                            fillColor: _backgroundColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _sifretekrarcontroller,
                          obscureText: !_isConfirmPasswordVisible,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            labelText: 'Şifre (Tekrar)',
                            labelStyle: const TextStyle(
                              color: Color(0xaa333333),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                color: Color(0xAAFF4545),
                                width: 2.0,
                              ),
                            ),
                            fillColor: _backgroundColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            passwordChange(_sifrecontroller.text,
                                _sifretekrarcontroller.text, context);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFF5283C1),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: const Center(
                              child: Text(
                                'KAYDET',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

passwordChange(password, repassword, context) async {
  if (password != repassword || password == '' || password == null) {
    notification(context, "Lütfen aynı olacak şekilde giriniz!");
  } else {
    var response = await PostServices.changePassword(password);
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (responseMap['status'] == '1') {
        notification(context, "Şifre başarıyla değiştirildi.");
      } else {
        notification(context, "Sunucu hatası!");
      }
    } else {
      notification(context, "Sunucu hatası veya ağ hatası!");
    }
  }
}

void _hesabimiSilButtonPressed(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Hesabınızı Sil"),
        content: const Text(
            "Hesabınızı silmek istediğinizden emin misiniz? Bu İşlem Geri Alınamaz!"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("İptal"),
          ),
          ElevatedButton(
            onPressed: () async {
              var response = await PostServices.hesabimisil();
              var ara = json.decode(response.body);
              // Navigator.of(context).pop();

              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF5283C1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
            ),
            child: Text(
              "Evet",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
