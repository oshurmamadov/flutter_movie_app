
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:share/share.dart';

class MovieDetail extends StatelessWidget {
  final movie;
  final mainColor = const Color(0xff3C3261);
  final imageUrl = 'https://image.tmdb.org/t/p/w500/';

  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
              imageUrl + movie['poster_path'],
              fit: BoxFit.cover
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5)
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 400,
                      height: 400,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl + movie['poster_path']),
                        fit: BoxFit.cover
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 20.0,
                          offset: Offset(0, 10)
                        )
                      ]
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: getSimpleText(movie['title'], 30),
                        ),
                        getSimpleText('${movie['vote_average']}/10', 20)
                      ],
                    ),
                  ),
                  getSimpleText(movie['overview'], 14),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: 150,
                          height: 60,
                          alignment: Alignment.center,
                          child: getSimpleText('Rate Movie', 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xaa3C3261)
                          ),
                        ),
                      ),
                      getSimpleIcon(icon: Icons.share, callback: (){
                        Share.share(
                            'Check my website bruh www.siska.tv'
                        );
                      }),
                      getSimpleIcon(icon: Icons.bookmark)
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

getSimpleText(String text, double size) => Text(
    text,
    style: TextStyle(
        color: Colors.white,
        fontFamily: 'Arvo',
        fontSize: size
    )
);


// ignore: avoid_init_to_null
getSimpleIcon({IconData icon, VoidCallback callback}) {
  return FlatButton(
    child: Padding(
        padding: const EdgeInsets.all(16),
        child: new Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: new Icon(
            icon,
            color: Colors.white,
          ),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              color: const Color(0xaa3C3261)),
        )
    ),
    onPressed: callback
  );
}