import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF5283C1),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/images/profile_picture.jpg'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'İbrahim Doğan',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5283C1),
                      ),
                    ),
                    Text(
                      'Circular Mind',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: () {},
                      splashColor:
                          Colors.transparent, // Tıklama efektini kaldırmak için
                      highlightColor:
                          Colors.transparent, // Tıklama efektini kaldırmak için
                      child: Text(
                        'Profili Düzenle',
                        style: TextStyle(
                          color: Color(0xFF5283C1),
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                      onHighlightChanged: (isHighlighted) {
                        // Tıklama sırasında rengin bir tık koyulaşmasını sağlamak için
                        if (isHighlighted) {
                          // Rengi koyulaştır
                        } else {
                          // Orijinal rengi geri getir
                        }
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              MenuItem(
                icon: Icons.directions_car,
                text: 'Araçlarım',
                onTap: () {},
              ),
              MenuItem(
                icon: Icons.directions_walk,
                text: 'Yolculuklarım',
                onTap: () {},
              ),
              MenuItem(
                icon: Icons.store,
                text: 'Vitrin',
                onTap: () {},
              ),
              MenuItem(
                icon: Icons.help,
                text: 'Nasıl Kullanırım?',
                onTap: () {},
              ),
              MenuItem(
                icon: Icons.contact_mail,
                text: 'Bize Ulaşın',
                onTap: () {},
              ),
              MenuItem(
                icon: Icons.info,
                text: 'Hakkında',
                onTap: () {},
              ),
              MenuItem(
                icon: Icons.logout,
                text: 'Çıkış Yap',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xFFF3F5F8),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade100,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: Color(0xFF5283C1)),
              SizedBox(width: 16),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
