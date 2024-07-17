import 'dart:convert';
import 'package:flutter/material.dart';
import '../Services/auth_services.dart';
import 'functions/widget.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _password = '';
  String _name = '';
  String _phone = '';
  String _confirmpas = '';
  int cinsiyet = 2;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool isChecked = false;
  bool isButtonEnabled = false;
  bool hasMinLength = false;
  bool hasUpperCase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;
  bool passwordsMatch = false;

  void checkPasswords(String password, String confirmPassword) {
    setState(() {
      hasMinLength = password.length >= 8;
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasDigits = password.contains(RegExp(r'[0-9]'));
      hasSpecialCharacters =
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      passwordsMatch = password == confirmPassword;
    });
  }

  createAccountPressed() async {
    if (_password != _confirmpas) {
      notification(context, "Şifreler uyuşmuyor, lütfen tekrar deneyiniz.");
      return false;
    } else if (_password == "") {
      notification(context, "Şifre alanı boş bırakılamaz!");
      return false;
    } else {
      http.Response response = await AuthServices.register(
          _name, _email, _password, _phone, cinsiyet);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        //return false;
        var code = (responseMap.values.toList()[1]['code']);
        var mesaj = (responseMap.values.toList()[1]['mesaj']);
        notification(context, mesaj.toString());
        if (code.toString() == "1") {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen(),
              ));
        }
      } else {
        notification(context, responseMap.values.first[0]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/reg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.07,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: screenHeight * 0.2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: screenHeight * 0.015),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Kayıt olmak için lütfen aşağıdaki formu doldurun.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.025,
                                        fontFamily: 'Inria Sans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    right: screenWidth * 0.05,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.03,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Ad Soyad',
                                        hintStyle: TextStyle(
                                          color: const Color(0xFFF5F5F5)
                                              .withOpacity(0.7),
                                          fontSize: screenWidth * 0.03,
                                          fontFamily: 'Inria Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFD9D9D9)
                                            .withOpacity(0.3),
                                        contentPadding: const EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10.0,
                                            left: 20.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.0)),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        _name = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    right: screenWidth * 0.05,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.03,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'E-Mail',
                                        hintStyle: TextStyle(
                                          color: const Color(0xFFF5F5F5)
                                              .withOpacity(0.7),
                                          fontSize: screenWidth * 0.03,
                                          fontFamily: 'Inria Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFD9D9D9)
                                            .withOpacity(0.3),
                                        contentPadding: const EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10.0,
                                            left: 20.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.0)),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    right: screenWidth * 0.05,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.03,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Telefon',
                                        hintStyle: TextStyle(
                                          color: const Color(0xFFF5F5F5)
                                              .withOpacity(0.7),
                                          fontSize: screenWidth * 0.03,
                                          fontFamily: 'Inria Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFD9D9D9)
                                            .withOpacity(0.3),
                                        contentPadding: const EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10.0,
                                            left: 20.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.0)),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        _phone = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Theme(
                                          data: ThemeData(
                                            unselectedWidgetColor:
                                                Color(0xFFA2FF45),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Radio(
                                                value: 0,
                                                groupValue: cinsiyet,
                                                onChanged: (value) {
                                                  setState(() {
                                                    cinsiyet = value!;
                                                  });
                                                },
                                                activeColor: Color(0xFFA2FF45),
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              Text(
                                                "Erkek",
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFFF5F5F5),
                                                  fontSize: screenWidth * 0.03,
                                                  fontFamily: 'Inria Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Theme(
                                          data: ThemeData(
                                            unselectedWidgetColor:
                                                Color(0xFFA2FF45),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Radio(
                                                value: 1,
                                                groupValue: cinsiyet,
                                                onChanged: (value) {
                                                  setState(() {
                                                    cinsiyet = value!;
                                                  });
                                                },
                                                activeColor: Color(0xFFA2FF45),
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              Text(
                                                "Kadın",
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFFF5F5F5),
                                                  fontSize: screenWidth * 0.03,
                                                  fontFamily: 'Inria Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Theme(
                                          data: ThemeData(
                                            unselectedWidgetColor:
                                                Color(0xFFA2FF45),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Radio(
                                                value: 2,
                                                groupValue: cinsiyet,
                                                onChanged: (value) {
                                                  setState(() {
                                                    cinsiyet = value!;
                                                  });
                                                },
                                                activeColor: Color(0xFFA2FF45),
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              Text(
                                                "Belirtmek İstemiyorum",
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFFF5F5F5),
                                                  fontSize: screenWidth * 0.03,
                                                  fontFamily: 'Inria Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        right: screenWidth * 0.05,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          obscureText: !_isPasswordVisible,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth * 0.03,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Şifre',
                                            hintStyle: TextStyle(
                                              color: const Color(0xFFF5F5F5)
                                                  .withOpacity(0.7),
                                              fontSize: screenWidth * 0.03,
                                              fontFamily: 'Inria Sans',
                                              fontWeight: FontWeight.w600,
                                            ),
                                            filled: true,
                                            fillColor: const Color(0xFFD9D9D9)
                                                .withOpacity(0.3),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10.0,
                                                    bottom: 10.0,
                                                    left: 20.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(0.0)),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.red),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.red),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _isPasswordVisible
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isPasswordVisible =
                                                      !_isPasswordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                          onChanged: (value) {
                                            _password = value;
                                            checkPasswords(
                                                _password, _confirmpas);
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        right: screenWidth * 0.05,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          obscureText:
                                              !_isConfirmPasswordVisible,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth * 0.03,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Şifre Tekrar',
                                            hintStyle: TextStyle(
                                              color: const Color(0xFFF5F5F5)
                                                  .withOpacity(0.7),
                                              fontSize: screenWidth * 0.03,
                                              fontFamily: 'Inria Sans',
                                              fontWeight: FontWeight.w600,
                                            ),
                                            filled: true,
                                            fillColor: const Color(0xFFD9D9D9)
                                                .withOpacity(0.3),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10.0,
                                                    bottom: 10.0,
                                                    left: 20.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(0.0)),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.red),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              borderSide: const BorderSide(
                                                  color: Colors.red),
                                            ),
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
                                          onChanged: (value) {
                                            _confirmpas = value;
                                            checkPasswords(
                                                _password, _confirmpas);
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          hasMinLength
                                              ? Icons.check
                                              : Icons.close,
                                          color: hasMinLength
                                              ? Color(0xFFA2FF45)
                                              : Colors.white54,
                                          size: 12,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'En az 8 karakter',
                                          style: TextStyle(
                                            color: hasMinLength
                                                ? Color(0xFFA2FF45)
                                                : Colors.white54,
                                            fontSize: screenWidth * 0.03,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          hasUpperCase
                                              ? Icons.check
                                              : Icons.close,
                                          color: hasUpperCase
                                              ? Color(0xFFA2FF45)
                                              : Colors.white54,
                                          size: 12,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Büyük harf içermeli',
                                          style: TextStyle(
                                            color: hasUpperCase
                                                ? Color(0xFFA2FF45)
                                                : Colors.white54,
                                            fontSize: screenWidth * 0.03,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          hasDigits ? Icons.check : Icons.close,
                                          color: hasDigits
                                              ? Color(0xFFA2FF45)
                                              : Colors.white54,
                                          size: 12,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Rakam içermeli',
                                          style: TextStyle(
                                            color: hasDigits
                                                ? Color(0xFFA2FF45)
                                                : Colors.white54,
                                            fontSize: screenWidth * 0.03,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          hasSpecialCharacters
                                              ? Icons.check
                                              : Icons.close,
                                          color: hasSpecialCharacters
                                              ? Color(0xFFA2FF45)
                                              : Colors.white54,
                                          size: 12,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Özel karakter içermeli',
                                          style: TextStyle(
                                            color: hasSpecialCharacters
                                                ? Color(0xFFA2FF45)
                                                : Colors.white54,
                                            fontSize: screenWidth * 0.03,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: checkbox(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                            right: screenWidth * 0.05,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: isButtonEnabled
                                  ? () {
                                      createAccountPressed();
                                    }
                                  : null,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFA2FF45)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                ),
                              ),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  'Kaydol',
                                  style: TextStyle(
                                    color: const Color(0xFF111111)
                                        .withOpacity(0.7),
                                    fontSize: screenWidth * 0.03,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                              ),
                              child: Text(
                                "Zaten hesabın var mı? Giriş Yapın.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.03,
                                  fontFamily: 'Inria Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkbox() {
    return Row(
      children: [
        Theme(
          data: ThemeData(
            checkboxTheme: CheckboxThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(
                  color: Color(0xFFA2FF45),
                  width: 2,
                ),
              ),
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Color(0xFFA2FF45);
                }
                return Colors.transparent;
              }),
              checkColor: MaterialStateProperty.all(Colors.black),
            ),
          ),
          child: Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                isButtonEnabled = value!;
              });
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 500,
                  child: WebView(
                    initialUrl: 'https://circularmind.com/privacy.html',
                  ),
                );
              },
            );
          },
          child: Text(
            'Gizlilik sözleşmesini okudum ve kabul ediyorum.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
