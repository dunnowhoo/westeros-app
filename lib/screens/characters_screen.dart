import 'package:flutter/material.dart';
import '../widgets/house_card.dart';
import 'package:westeros/screens/character_by_houses_screen.dart'; 
import 'package:westeros/models/house_model.dart';
import 'package:westeros/services/an_api_of_ice_and_fire.dart';

class House {
  final String name;
  final String image;
  final Color color;
  final String id;

  House({required this.name, required this.image, required this.color, required this.id});
}

class CharactersScreen extends StatefulWidget {
  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<House> houses = [
    House(
        name: "House Stark",
        image: "assets/images/stark.png",
        color: Colors.grey[800]!,
        id : '362',),
    House(
        name: "House Lannister",
        image: "assets/images/lannister.png",
        color: const Color.fromARGB(255, 211, 3, 3),
        id : '229',),
    House(
        name: "House Targaryen",
        image: "assets/images/targaryen.png",
        color: const Color.fromARGB(255, 130, 10, 10),
        id : '378',),
    House(
        name: "House Baratheon",
        image: "assets/images/baratheon.png",
        color: Colors.yellow[700]!,
        id : '16',),
    
    House(
        name: "House Greyjoy",
        image: "assets/images/greyjoy.png",
        color: Colors.blueGrey,
        id : '169',),
    House(
        name: "House Tully",
        image: "assets/images/tully.png",
        color: Colors.blue[800]!,
        id : '395',),
    House(
        name: "House Mormont",
        image: "assets/images/mormont.png",
        color: const Color.fromARGB(255, 25, 97, 27),
        id : '271',),
    House(
        name: "House Clegane",
        image: "assets/images/clegane.png",
        color: Colors.brown,
        id : '72',),

    House(
        name: "House Arryn",
        image: "assets/images/arryn.png",
        color: Colors.indigo[700]!,
        id : '7',),
    House(
        name: "House Tyrell",
        image: "assets/images/tyrell.png",
        color: Colors.green[800]!,
        id : '398',),
  ];

  int currentPage = 0;
  final IceAndFireService _iceandfire = IceAndFireService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller:
                      PageController(initialPage: 0, viewportFraction: 0.7),
                  itemCount: houses.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                     onTap: () async {
                        final houseId =
                            houses[index].id; 
                        try {
                          final fetchedHouse =
                              await _iceandfire.fetchHouse(int.parse(houseId));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CharacterByHouseScreen(house: fetchedHouse),
                            ),
                          );
                        } catch (e) {
                          print("Error fetching house with id $houseId: $e");
                        }
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        transform: Matrix4.identity()
                          ..scale(currentPage == index ? 1.1 : 1.0),
                        decoration: BoxDecoration(
                          boxShadow: currentPage == index
                              ? [
                                  BoxShadow(
                                    color: houses[index].color.withOpacity(0.5),
                                    blurRadius: 105,
                                    spreadRadius: 15,
                                    offset: const Offset(0, 20),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Image.asset(
                            houses[index].image,
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.6,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(houses.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: currentPage == index ? 12.0 : 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPage == index
                              ? houses[index].color
                              : Colors.white30,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
