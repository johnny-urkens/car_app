import 'package:flutter/material.dart';

import '../apis/car_api.dart';
import '../models/car.dart';

class ListPage extends StatelessWidget {
  String name;

  ListPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testtekst"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: const CarList(),
      ),
    );
  }
}

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  CarListState createState() {
    return CarListState();
  }
}

class CarListState extends State<CarList> {
  List<Car> carList = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getCars();
  }

  void _getCars() {
    CarApi.fetchCars().then((result) {
      setState(() {
        carList = result;
        count = result.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: Column(
            children: [
              Text(carList[position].carBrand),
              Text('Maximum Speed  ${carList[position].maxSpeed}'),
              Text('Number of seats  ${carList[position].numberOfSeats}'),
            ],
          ),
        );
      },
    );
  }
}
