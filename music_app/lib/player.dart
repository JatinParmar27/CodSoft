import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  // ignore: non_constant_identifier_names
  List Songs = [
    {
      "name": "Ghammar Ghammar",
      "thumbnail": "assets/img/Ghammar Ghammar.jpg",
      "path": "songs/Ghammar Ghammar.mp3",
      "artist": "Adity Gadhvi",
      "type": "Gujarati Folk"
    },
    {
      "name": "Gulabi Sadi",
      "thumbnail": "assets/img/GulabiSadi.jpg",
      "path": "songs/GulabiSadi.mp3",
      "artist": "Sanju Rathod",
      "type": "Marathi Song"
    },
    {
      "name": "Musafir",
      "thumbnail": "assets/img/Musafir.jpg",
      "path": "songs/Musafir.mp3",
      "artist": "Aatif Aslam",
      "type": "Bollywood Song"
    },
    {
      "name": "Naacho Naacho",
      "thumbnail": "assets/img/Naacho Naacho.jpg",
      "path": "songs/Naacho Naacho.mp3",
      "artist": "Vishal Mishra",
      "type": "Energetic song"
    },
    {
      "name": "Naina Da Kya Kasoor",
      "thumbnail": "assets/img/Naina Da Kya Kasoor.jpg",
      "path": "songs/Naina Da Kya Kasoor.mp3",
      "artist": "Aayushman Khurrana",
      "type": "Bollywood Song"
    },
    {
      "name": "Pushpa Pushpa",
      "thumbnail": "assets/img/Pushpa.jpg",
      "path": "songs/Pushpa.mp3",
      "artist": "Mika",
      "type": "Telgu Song"
    },
    {
      "name": "Senorita",
      "thumbnail": "assets/img/Senorita.jpg",
      "path": "songs/Senorita.mp3",
      "artist": "Ritik Roshan",
      "type": "Bollywood Song"
    },
    {
      "name": "Tere Hawaale",
      "thumbnail": "assets/img/Tere Hawale.jpg",
      "path": "songs/Tere Hawale.mp3",
      "artist": "Arijit Singh",
      "type": "Bollywood Love Song"
    },
    {
      "name": "Zingaat",
      "thumbnail": "assets/img/Zingaat.jpg",
      "path": "songs/Zingaat.mp3",
      "artist": "Ajay Atul",
      "type": "Marathi Dance Song"
    }
  ];

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        this.position = position;
      });
    });

    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        this.duration = duration;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>;

    var i = routes['index']?.toInt();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Player"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                child: Image.asset(Songs[i ?? 0]["thumbnail"])),
            Container(
              child: Column(
                children: [
                  Text(
                    Songs[i ?? 0]["name"],
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Songs[i ?? 0]["artist"],
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final newPosition = Duration(seconds: value.toInt());
                await audioPlayer.seek(newPosition);
                setState(() {
                  position = newPosition;
                });
              },
            ),
            CircleAvatar(
              child: IconButton(
                  onPressed: () async {
                    if (isPlaying == false) {
                      var assetSource = AssetSource(Songs[i ?? 0]["path"]);
                      audioPlayer.play(assetSource);
                    } else {
                      await audioPlayer.pause();
                    }
                  },
                  icon: isPlaying == false
                      ? const Icon(Icons.play_arrow)
                      : const Icon(Icons.pause)),
            )
          ],
        ),
      ),
    );
  }
}
