// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfilePageTest extends StatelessWidget {
  const ProfilePageTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: screenWidth,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Selam, Ufuk',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5283C1),
                        ),
                      ),
                      Text(
                        'Hoş Geldiniz',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF5283C1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kişisel Bilgiler',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5283C1),
                              ),
                            ),
                            SizedBox(height: 8),
                            _buildPersonalInfoRow(Icons.phone, 'Telefon Numarası', '+90 507 843 36 60'),
                            _buildPersonalInfoRow(Icons.business, 'Firma', 'Circular Mind'),
                            _buildPersonalInfoRow(Icons.calendar_today, 'Doğum Tarihi', '24 Eylül 1996'),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF5283C1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BUGÜN ATILAN ADIM SAYISI',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '2427/10000',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(Icons.directions_walk, color: Colors.white),
                              ],
                            ),
                            SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: 2427 / 10000,
                              color: Colors.yellow,
                              backgroundColor: Color(0xFF5283C1).withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      TabBar(
                        indicatorColor: Color(0xFF5283C1),
                        labelColor: Color(0xFF5283C1),
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(text: 'PUAN'),
                          Tab(text: 'GEÇMİŞ'),
                          Tab(text: 'ŞİFRE'),
                        ],
                      ),
                      SizedBox(
                        height: 350,
                        child: TabBarView(
                          children: [
                            _buildStatsTab(),
                            _buildHistoryTab(),
                            _buildEditTab(),
                          ],
                        ),
                      ),
                      // SizedBox(height: 16),
                      // ElevatedButton.icon(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.share, color: Colors.white),
                      //   label: Text('Share My Stats',
                      //       style: TextStyle(color: Colors.white)),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Color(0xFF5283C1),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     minimumSize: Size(double.infinity, 50),
                      //   ),
                      // ),
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

  Widget _buildPersonalInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF5283C1), size: 20),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF5283C1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStatItem('4.48', 'Ortalama Puan'),
          _buildStatItem('4.39', 'Eko Puan'),
          _buildStatItem('17 KM', 'Ortalama KM'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5283C1),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF5283C1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Geçmiş Yolculuk Bulunmamaktadır',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF5283C1),
          ),
        ),
      ),
    );
  }

  Widget _buildEditTab() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF5283C1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Şifre Değiştir',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5283C1),
            ),
          ),
          SizedBox(height: 16),
          _buildPasswordField('Mevcut Şifre', Icons.lock),
          SizedBox(height: 16),
          _buildPasswordField('Yeni Şifre', Icons.lock_outline),
          SizedBox(height: 16),
          _buildPasswordField('Yeni Şifre Tekrarı', Icons.lock_outline),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Şifre değiştirme işlemleri burada yapılacak
            },
            icon: Icon(Icons.save, color: Colors.white),
            label: Text(
              'Kaydet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF5283C1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String hintText, IconData icon) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFF5283C1)),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF5283C1)),
        ),
      ),
    );
  }
}
