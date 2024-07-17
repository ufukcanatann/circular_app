import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Classes/Users.dart';
import '../Services/auth_services.dart';
import 'HomePage.dart';
import 'functions/widget.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  bool isChecked = false;
  bool _isPasswordVisible = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      var response = await AuthServices.login(_email, _password);
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPreferences prefs = await _prefs;
        SharedPreferences shared_User = await SharedPreferences.getInstance();
        String user = jsonEncode(Users.fromJson(responseMap['data']));
        shared_User.setString('user', user);

        Map<String, dynamic> userMap =
            jsonDecode(prefs.getString('user').toString());
        var useraa = Users.fromJson(userMap);
        var id = (responseMap.values.toList()[1]['id']);
        await prefs.setString("id", id.toString());

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomePage(),
            ));
      } else {
        notification(context, responseMap['data']['error']);
      }
    } else {
      notification(context, "Lütfen eksik bırakılan alanları doldurunuz!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;
            bool isPortrait = screenHeight > screenWidth;
            bool isTablet = screenWidth > 600;
            double containerWidth = screenWidth * 0.8;

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: screenWidth,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/login.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Circular MiND!\nAracını takip et,\nYol boyunca kazan.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet
                                        ? screenWidth * 0.05
                                        : screenWidth * 0.077,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                Text(
                                  "Yolculuk artık daha eğlenceli. Kullandıkça kazandıran uygulamaya hoş geldin.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet
                                        ? screenWidth * 0.02
                                        : screenWidth * 0.03,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                TextField(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet
                                        ? screenWidth * 0.025
                                        : screenWidth * 0.04,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'E-Mail',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFFF5F5F5)
                                          .withOpacity(0.7),
                                      fontSize: isTablet
                                          ? screenWidth * 0.025
                                          : screenWidth * 0.04,
                                      fontFamily: 'Inria Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFD9D9D9)
                                        .withOpacity(0.3),
                                    contentPadding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0, left: 20.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.0)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _email = value;
                                  },
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  obscureText: !_isPasswordVisible,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet
                                        ? screenWidth * 0.025
                                        : screenWidth * 0.04,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Şifre',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFFF5F5F5)
                                          .withOpacity(0.7),
                                      fontSize: isTablet
                                          ? screenWidth * 0.025
                                          : screenWidth * 0.04,
                                      fontFamily: 'Inria Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFD9D9D9)
                                        .withOpacity(0.3),
                                    contentPadding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0, left: 20.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.0)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
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
                                  },
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Şifrenizi mi unuttunuz?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isTablet
                                          ? screenWidth * 0.02
                                          : screenWidth * 0.03,
                                      fontFamily: 'Inria Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: () {
                                    loginPressed();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5283C1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Giriş Yap',
                                      style: TextStyle(
                                        color: const Color(0xFFF5F5F5),
                                        fontSize: isTablet
                                            ? screenWidth * 0.025
                                            : screenWidth * 0.035,
                                        fontFamily: 'Inria Sans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const RegisterScreen(),
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3B4B6B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Kaydol',
                                      style: TextStyle(
                                        color: const Color(0xFFF5F5F5),
                                        fontSize: isTablet
                                            ? screenWidth * 0.025
                                            : screenWidth * 0.035,
                                        fontFamily: 'Inria Sans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
