class DataModel {
  String? name, email, mobile, image;

  DataModel(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.image});

  factory DataModel.fromMap(Map m1) {
    return DataModel(
      name: m1['name'],
      email: m1['email'],
      mobile: m1['contact'],
      image: m1['image'],
    );
  }
}
