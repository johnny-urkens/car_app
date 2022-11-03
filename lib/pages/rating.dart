import 'package:flutter/material.dart';
import '../apis/car_api.dart';
import '../models/rating.dart';

class RatingPage extends StatefulWidget {
  final String carBrand;
  final List userScores;
  const RatingPage({Key? key, required this.carBrand, required this.userScores})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  Rating? rating;

  @override
  void initState() {
    if (widget.carBrand == "" || widget.userScores == []) {
      rating = Rating(carBrand: "", userScores: []);
    } else {
      _getRating(widget.carBrand, widget.userScores);
    }
  }

  void _getRating(String carBrand, List userScores) {
    CarApi.fetchRating(carBrand, userScores).then((result) => {
          setState(() {
            rating = result;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    Image image;
    if (rating == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      var i = rating!.carBrand;
      return Scaffold(
        appBar: AppBar(
          title: const Text('DetailPage'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image = Image(
                image: AssetImage('assets/$i.jpg'),
                width: 315,
                height: 110,
              ),
              Text(rating!.carBrand),
              Text(rating!.userScores[0].userName),
              Text(rating!.userScores[0].scoreNumber.toString()),
            ],
          ),
        ),
      );
    }
  }
}
