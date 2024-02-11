class User {
  late int user_id;
  late String username;
  late String password;
  late String name;
  late String gender;
  late double weight;
  late double height;
  late DateTime date_of_birth;
  late String type;
  late String email;
  late String contact;

  User(
      int user_id,
      String username,
      String password,
      String name,
      String gender,
      double weight,
      double height,
      String dob,
      String type,
      String email,
      String contact) {
    this.user_id = user_id;
    this.username = username;
    this.password = password;
    this.name = name;
    this.gender = gender;
    this.weight = weight;
    this.height = height;
    this.email = email;
    this.contact = contact;

    int year = int.parse(dob.substring(0, 4));
    int month;
    int day;
    String temp = dob.substring(5);
    if (int.tryParse(temp[1]) == null) {
      month = int.parse(temp[0]);
      temp = temp.substring(2);
    } else {
      month = int.parse(temp.substring(0, 2).toString());
      temp = temp.substring(3);
    }
    if (temp.length == 1) {
      day = int.parse(temp[0]);
    } else {
      int? tempa = int.tryParse(temp.substring(0, 2));
      day = (tempa == null) ? int.parse(temp[0]) : tempa;
    }
    this.date_of_birth = DateTime(year, month, day);
    this.type = type;
  }

  String getdate() {
    return "${date_of_birth.year}-${date_of_birth.month}-${date_of_birth.day}";
  }
}
