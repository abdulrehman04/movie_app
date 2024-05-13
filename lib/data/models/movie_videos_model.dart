import 'dart:convert';

MovieVideosModel movieVideosModelFromJson(String str) =>
    MovieVideosModel.fromJson(json.decode(str));

String movieVideosModelToJson(MovieVideosModel data) =>
    json.encode(data.toJson());

class MovieVideosModel {
  int id;
  List<Result> results;

  MovieVideosModel({
    required this.id,
    required this.results,
  });

  factory MovieVideosModel.fromJson(Map<String, dynamic> json) =>
      MovieVideosModel(
        id: json["id"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String name;
  String key;
  Site site;
  int size;
  Type type;
  bool official;
  DateTime publishedAt;
  String id;

  Result({
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        key: json["key"],
        site: siteValues.map[json["site"]]!,
        size: json["size"],
        type: typeValues.map[json["type"]]!,
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
        "site": siteValues.reverse[site],
        "size": size,
        "type": typeValues.reverse[type],
        "official": official,
        "published_at": publishedAt.toIso8601String(),
        "id": id,
      };
}

// ignore: constant_identifier_names
enum Site { YOU_TUBE }

final siteValues = EnumValues({"YouTube": Site.YOU_TUBE});

// ignore: constant_identifier_names
enum Type { BEHIND_THE_SCENES, CLIP, FEATURETTE, TEASER, TRAILER }

final typeValues = EnumValues({
  "Behind the Scenes": Type.BEHIND_THE_SCENES,
  "Clip": Type.CLIP,
  "Featurette": Type.FEATURETTE,
  "Teaser": Type.TEASER,
  "Trailer": Type.TRAILER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
