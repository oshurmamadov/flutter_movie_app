
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie_detail.dart';

class MovieList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

Future<Map> getJson() async {
  var url = 'http://api.themoviedb.org/3/discover/movie?api_key=fc6a574b6a0859af92c1635cd6a0980f';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class MovieListState extends State<MovieList> {
  var movies;
  Color mainColor = const Color(0xff3C3261);

  void getData() async {
    var data = await getJson();
    setState(() {
      movies = data['results'];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Movies',
          style: TextStyle(
            color: mainColor,
            fontFamily: 'Arvo',
            fontWeight: FontWeight.bold
          ),
        )
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MovieTitle(mainColor),
              Expanded(
                child: ListView.builder(
                    itemCount: movies == null ? 0 : movies.length,
                    itemBuilder: (context, i) {
                      return FlatButton(
                        child: MovieCell(movies, i),
                        padding: EdgeInsets.all(0.0),
                        color: Colors.white,
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MovieDetail(movies[i]);
                                }
                              )
                          );
                        }
                      );
                    }
                ),
              )
            ],
          )
      ),
    );
  }
}

class MovieTitle extends StatelessWidget {
  final Color mainColor;

  MovieTitle(this.mainColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Center(
        child: Text(
          'Top Rated',
          style: TextStyle(
              fontSize: 40.0,
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arvo'
          ),
          textAlign: TextAlign.center,
        )
      ),
    );
  }
}

class MovieCell extends StatelessWidget {

  final movies;
  final i;
  final Color mainColor = const Color(0xff3C3261);
  final imageUrl = 'https://image.tmdb.org/t/p/w500/';

  MovieCell(this.movies, this.i);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0),
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Container(
                  width: 70.0,
                  height: 70.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl + movies[i]['poster_path'])
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: mainColor,
                      blurRadius: 5.0,
                      offset: Offset(2, 5)
                    )
                  ]
                ),
              )
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      movies[i]['title'],
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Avro',
                          fontWeight: FontWeight.bold,
                          color: mainColor
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(2)
                    ),
                    Text(
                      movies[i]['overview'],
                      maxLines: 3,
                      style: TextStyle(
                          color: Color(0xff8785A4),
                          fontFamily: 'Avro'
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
            width: 300,
            height: 0.5,
            color: const Color(0xD2D2E1ff),
            margin: const EdgeInsets.all(16.0)
        )
      ],
    );
  }
}