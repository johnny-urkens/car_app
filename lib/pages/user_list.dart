import 'package:car_app/pages/list.dart';
import 'package:flutter/material.dart';
import '../pages/rating.dart';
import '../apis/car_api.dart';
import '../models/personalCar.dart';
import '../utils/user_secure_storage.dart';

class UserListPage extends StatefulWidget {
  const UserListPage();

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => UserListPageState();
}

class UserListPageState extends State {
  String naam1 = '';

  UserListPageState();
  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final naam = await UsersecureStorage.getUserName() ?? '';
    print('naam1' + naam);

    setState(() {
      naam1 = naam;
    });
    print('1 $naam1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: PersonalCarList(
          name: naam1,
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
  PersonalCarList? cars;
  late String name = widget.name;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final naam = await UsersecureStorage.getUserName() ?? '';
    print('naam1' + naam);

    setState(() {
      name = naam;
      _getPersonalCars();
    });
    print('2 $name');
  }

  void _getPersonalCars() {
    CarApi.fetchPersonalCars(name).then((result) {
      setState(() {
        carList = result;
        count = result.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (cars == null) {
    //   return const Center(child: CircularProgressIndicator());
    // } else {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 4 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        var t = carList[position].carBrand;
        List userScores = [];
        userScores.add(carList[position].userScores[0].userName);
        Image image;
        return Card(
          color: const Color.fromARGB(255, 227, 234, 233),
          elevation: 2.0,
          //Gesturedetector zorgt ervoor dat je de ontap methode kan gebruiken
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RatingPage(
                            carBrand: t,
                            userScores: userScores,
                          )));
              print(userScores);
              print(t);
            },
            child: Column(
              children: [
                image = Image(
                  image: AssetImage('assets/$t.jpg'),
                  width: 315,
                  height: 110,
                ),
                Text(carList[position].carBrand),
                Text(carList[position].userScores[0].userName),
                Text(carList[position].userScores[0].scoreNumber.toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}
// }
