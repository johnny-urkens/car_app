class PersonalCar {
  String carBrand;
  List userScores;
  // String userName;
  // int scoreNumber;

  PersonalCar({
    required this.carBrand,
    required this.userScores,
    // required this.scoreNumber,
    // required this.userName,
  });

  factory PersonalCar.fromJson(Map<String, dynamic> json) {
    return PersonalCar(
      carBrand: json['carBrand'],
      userScores: json['userScores'],
      // userName: userScores['userName'],
      // scoreNumber: json['scoreNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        'carbrand': carBrand,
        'userScores': userScores,
        // 'userName': userName,
        // 'scoreNumber': scoreNumber,
      };
}
