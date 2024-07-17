import 'package:flutter/material.dart';

class MasterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(fontFamily: 'Roboto'),
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> ilceler = ["İlçe 1", "İlçe 2", "İlçe 3"];
  List<String> semtler = ["Semt 1", "Semt 2", "Semt 3"];

  String selectedIlce = "İlçe 1";
  String selectedSemt = "Semt 1";

  List<Map<String, dynamic>> listeOgeleri = [
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 1"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 2"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 3"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 4"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 5"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 6"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 7"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 8"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 9"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 10"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 11"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 12"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 13"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 14"},
    {"photo": Icons.photo, "text1": "Fotoğraf", "text2": "Metin 15"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButton<String>(
                        value: selectedIlce,
                        onChanged: (newValue) {
                          setState(() {
                            selectedIlce = newValue!;
                          });
                        },
                        items: ilceler.map((String ilce) {
                          return DropdownMenuItem<String>(
                            value: ilce,
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFE8E8E8), // background-color
                                borderRadius: BorderRadius.circular(
                                    50.0), // border-radius
                              ),
                              child: Text(
                                ilce,
                                style: const TextStyle(
                                  color: Color(0xFF1d1d1d), // color
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),
                        underline: Container(
                          height:
                              0, // Altındaki mavi border'ı kaldırmak için 0 yapın
                        ),
                        elevation: 8,
                        isExpanded: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButton<String>(
                        value: selectedSemt,
                        onChanged: (newValue) {
                          setState(() {
                            selectedSemt = newValue!;
                          });
                        },
                        items: semtler.map((String semt) {
                          return DropdownMenuItem<String>(
                            value: semt,
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFE8E8E8), // background-color
                                borderRadius: BorderRadius.circular(
                                    50.0), // border-radius
                              ),
                              child: Text(
                                semt,
                                style: const TextStyle(
                                  color: Color(0xFF1d1d1d), // color
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),
                        underline: Container(
                          height:
                              0, // Altındaki mavi border'ı kaldırmak için 0 yapın
                        ),
                        elevation: 8,
                        isExpanded: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 2,
              color: Colors.grey,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: listeOgeleri.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Icon(listeOgeleri[index]["photo"]),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(listeOgeleri[index]["text1"]),
                              Text(listeOgeleri[index]["text2"]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MasterPage());
}
