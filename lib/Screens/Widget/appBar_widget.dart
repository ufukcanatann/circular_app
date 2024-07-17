import 'package:flutter/material.dart';

PreferredSize titleBar(BuildContext context, String title) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
    child: AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xff1D1D1D),
          ),
        ),
      ),
      centerTitle: true,
    ),
  );
}
