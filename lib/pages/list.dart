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
        title: const Text("Alle Wagens"),
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
        Image image;
        return Card(
          color: Color.fromARGB(255, 227, 234, 233),
          elevation: 2.0,
          child: Column(
            children: [
              image = Image(
                image: AssetImage('assets/car$position.jpg'),
                width: 315,
                height: 110,
              ),
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
