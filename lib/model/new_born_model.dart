class NewBornModel {
  NewBornModel({
    required this.data,
    required this.meta,
    required this.links,
  });

  List<Datum> data;
  Meta meta;
  NewBornModelLinks links;

  factory NewBornModel.fromJson(Map<String, dynamic> json) => NewBornModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
    links: NewBornModelLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta.toJson(),
    "links": links.toJson(),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.type,
    required this.links,
    required this.attributes,
  });

  String id;
  String type;
  DatumLinks links;
  Attributes attributes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    links: DatumLinks.fromJson(json["links"]),
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
  String? gestation;
  String? firstCryPushDate;
  String name;
  int userId;
  String createdAt;
  String updatedAt;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    gender: json["gender"],
    gestation: json["gestation"],
    firstCryPushDate: json["first_cry_push_date"],
    name: json["name"],
    userId: json["user_id"],
    createdAt: json["created_at"].toString(),
    updatedAt:json["updated_at"].toString(),
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

class DatumLinks {
  DatumLinks({
    required this.self,
  });

  String self;

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    self: json["self"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
  };
}

class NewBornModelLinks {
  NewBornModelLinks({
    required this.first,
    required this.last,
  });

  String first;
  String last;

  factory NewBornModelLinks.fromJson(Map<String, dynamic> json) => NewBornModelLinks(
    first: json["first"],
    last: json["last"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
  };
}

class Meta {
  Meta({
    required this.recordCount,
  });

  int recordCount;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    recordCount: json["record_count"],
  );

  Map<String, dynamic> toJson() => {
    "record_count": recordCount,
  };
}
