
class NewBornModel {
  NewBornModel({
    required this.id,
    required this.type,
    required this.links,
    required this.attributes,
  });

  String id;
  String type;
  Links links;
  Attributes attributes;

  factory NewBornModel.fromJson(Map<String, dynamic> json) => NewBornModel(
    id: json["id"],
    type: json["type"],
    links: Links.fromJson(json["links"]),
    attributes: Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "links": links.toJson(),
    "attributes": attributes.toJson(),
  };
}

class Attributes {
  Attributes({
    required this.gender,
    required this.gestation,
    required this.firstCryPushDate,
    required this.name,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  String gender;
  String gestation;
  String firstCryPushDate;
  String name;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    gender: json["gender"],
    gestation: json["gestation"],
    firstCryPushDate: json["first_cry_push_date"],
    name: json["name"],
    userId: json["user_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "gestation": gestation,
    "first_cry_push_date": firstCryPushDate,
    "name": name,
    "user_id": userId,
    "created_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
  };
}

class Links {
  Links({
    required this.self,
  });

  String self;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: json["self"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
  };
}
