import 'package:flutter/material.dart';

class HouseCard extends StatelessWidget {
  final String image;
  final String houseName;
  final Color borderColor;

  const HouseCard({
    Key? key,
    required this.image,
    required this.houseName,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 32.0,
          left: 8.0,
          right: 8.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
                color: borderColor, width: 3), // Warna border khas House
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(image), // Menggunakan asset untuk gambar House
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(
                houseName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
