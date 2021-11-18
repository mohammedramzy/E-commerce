class Category {
  Category({
    this.id,
    this.name,
    this.avatar,
  });

  int id;
  String name;
  String avatar;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };
}
