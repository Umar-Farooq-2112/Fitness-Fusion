
class DB {
  static late String url = 'http://localhost:4000/';
  late String api;
  DB(String api) {
    this.api = api;
  }
  String getLink() {
    return url + api;
  }
}

class TempUser {
  late int user_id;
  TempUser(int user_id) {
    this.user_id = user_id;
  }

  factory TempUser.fromJson(Map<String, dynamic> json) {
    return new TempUser(
      json['user_id'] as int,
    );
  }
}

