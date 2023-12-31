class Favorite {
  int? id;
  late String name;

  Favorite(this.name);

  Favorite.fromMap(Map map) {
    this.id = map["id"];
    this.name = map["name"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"name": this.name};

    if (this.id != null) {
      map["id"] = this.id;
    }
    return map;
  }
}
