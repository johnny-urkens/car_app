import 'package:flutter/material.dart';

import '../apis/car_api.dart';
import '../models/PersonalCar.dart';
import '../models/car.dart';

class UserListPage extends StatelessWidget {
  String name;

  UserListPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: PersonalCarList(
          name: name,
        ),
      ),
    );
  }
}

class PersonalCarList extends StatefulWidget {
  String name;

  PersonalCarList({super.key, required this.name});

  @override
  PersonalCarListState createState() {
    return PersonalCarListState();
  }
}

class PersonalCarListState extends State<PersonalCarList> {
  List<PersonalCar> carList = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getPersonalCars();
  }

  void _getPersonalCars() {
    CarApi.fetchPersonalCars(widget.name).then((result) {
      setState(() {
        carList = result;
        count = result.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // AssetImage asset = AssetImage('assets/audi.jpg');
    // Image image = Image(image: asset);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 4 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        var t = carList[position].carBrand;
        Image image;
        return Card(
          color: Color.fromARGB(255, 227, 234, 233),
          elevation: 2.0,
          child: Column(
            children: [
              image = Image(
                image: AssetImage('assets/$t.jpg'),
                width: 315,
                height: 110,
              ),
              Text(carList[position].carBrand),
              Text((carList[position].userScores[0]).toString()),
            ],
          ),
        );
      },
    );
  }
}
