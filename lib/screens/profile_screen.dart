import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/profile.png",
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 160), 
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Fauzan Putra Sanjaya",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.verified,
                          color: const Color.fromARGB(255, 193, 131, 37), size: 20), 
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.work, color: Colors.white70, size: 18),
                      SizedBox(width: 5),
                      Text("Information Systems Student",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.school, color: Colors.white70, size: 18),
                      SizedBox(width: 5),
                      Text("University of Indonesia",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.085, 
            minChildSize: 0.085,
            maxChildSize: 0.5, 
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.9),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Text("About Me",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text(
                        "👋 Valar Morghulis, I am Fauzan Putra Sanjaya—though you may call me Fauzan. By day, I'm an Information Systems student at the University of Indonesia (currently forging my path in semester 4). By night, I immerse myself in the epic tales of Westeros. My passion for Game of Thrones has inspired me to craft this app—a digital keep where every GOT enthusiast can gather and revel in the saga. Welcome to a realm where technology meets legend!",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 20),
                      Text("More Info",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 10, 
                        runSpacing: 10,
                        children: [
                          _infoTag("Hobby : Binge Watching"),
                          _infoTag("Instagram : @fauzanputra.s"),
                          _infoTag("a Targaryen"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _infoTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
