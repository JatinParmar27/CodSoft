import 'package:flutter/material.dart';

class Musiclist extends StatefulWidget {
  const Musiclist({super.key});

  @override
  State<Musiclist> createState() => _MusiclistState();
}

class _MusiclistState extends State<Musiclist> {
  List Songs = [
    {
      "name": "Ghammar Ghammar",
      "thumbnail": "assets/img/Ghammar Ghammar.jpg",
      "path": "assets/songs/Ghammar Ghammar.mp3",
      "artist": "Adity Gadhvi",
      "type": "Gujarati Folk"
    },
    {
      "name": "Gulabi Sadi",
      "thumbnail": "assets/img/GulabiSadi.jpg",
      "path": "assets/songs/GulabiSadi.mp3",
      "artist": "Sanju Rathod",
      "type": "Marathi Song"
    },
    {
      "name": "Musafir",
      "thumbnail": "assets/img/Musafir.jpg",
      "path": "assets/songs/Musafir.mp3",
      "artist": "Aatif Aslam",
      "type": "Bollywood Song"
    },
    {
      "name": "Naacho Naacho",
      "thumbnail": "assets/img/Naacho Naacho.jpg",
      "path": "assets/songs/Naacho Naacho.mp3",
      "artist": "Vishal Mishra",
      "type": "Energetic song"
    },
    {
      "name": "Naina Da Kya Kasoor",
      "thumbnail": "assets/img/Naina Da Kya Kasoor.jpg",
      "path": "assets/songs/Naina Da Kya Kasoor.mp3",
      "artist": "Aayushman Khurrana",
      "type": "Bollywood Song"
    },
    {
      "name": "Pushpa Pushpa",
      "thumbnail": "assets/img/Pushpa.jpg",
      "path": "assets/songs/Pushpa.mp3",
      "artist": "Mika",
      "type": "Telgu Song"
    },
    {
      "name": "Senorita",
      "thumbnail": "assets/img/Senorita.jpg",
      "path": "assets/songs/Senorita.mp3",
      "artist": "Ritik Roshan",
      "type": "Bollywood Song"
    },
    {
      "name": "Tere Hawaale",
      "thumbnail": "assets/img/Tere Hawale.jpg",
      "path": "assets/songs/Tere Hawale.mp3",
      "artist": "Arijit Singh",
      "type": "Bollywood Love Song"
    },
    {
      "name": "Zingaat",
      "thumbnail": "assets/img/Zingaat.jpg",
      "path": "assets/songs/Zingaat.mp3",
      "artist": "Ajay Atul",
      "type": "Marathi Dance Song"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music List"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: Songs.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        Songs[index]["thumbnail"],
                        width: 60,
                        height: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Songs[index]["name"],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(Songs[index]["artist"]),
                        ],
                      ),
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/player",
                                  arguments: {'index': index});
                            },
                            icon: Icon(Icons.play_arrow)),
                      )
                    ]),
              );
            }),
      ),
    );
  }
}
