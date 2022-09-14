class Manga {
  int? id;
  String? name;
  String? romaji;
  String? description;
  String? status;
  String? startDate;
  String? poster;
  String? banner;
  int? anilistId;
  int? malId;
  int? mangaupdatesId;
  String? animePlanetSlug;
  int? kitsuId;
  String? fandom;
  String? magazine;
  int? volumeCount;
  bool? locked;
  String? lastUpdated;

  Manga(
      {this.id,
      this.name,
      this.romaji,
      this.description,
      this.status,
      this.startDate,
      this.poster,
      this.banner,
      this.anilistId,
      this.malId,
      this.mangaupdatesId,
      this.animePlanetSlug,
      this.kitsuId,
      this.fandom,
      this.magazine,
      this.volumeCount,
      this.locked,
      this.lastUpdated});

  Manga.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    romaji = json['romaji'];
    description = json['description'];
    status = json['status'];
    startDate = json['start_date'];
    poster = json['poster'];
    banner = json['banner'];
    anilistId = json['anilist_id'];
    malId = json['mal_id'];
    mangaupdatesId = json['mangaupdates_id'];
    animePlanetSlug = json['anime_planet_slug'];
    kitsuId = json['kitsu_id'];
    fandom = json['fandom'];
    magazine = json['magazine'];
    volumeCount = json['volume_count'];
    locked = json['locked'];
    lastUpdated = json['last_updated'];
  }
}

class Volume {
  int? number;
  String? poster;
  List<String>? chapters;

  Volume({this.number, this.poster, this.chapters});

  Volume.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    poster = json['poster'];
    chapters = json['chapters'].cast<String>();
  }

  static List<Volume> fromJsonList(List<dynamic> json) {
    var results = <Volume>[];
    for (var j in json) {
      var r = Volume.fromJson(j);
      results.add(r);
    }
    return results;
  }
}

class Results {
  int? total;
  List<Manga>? manga;

  Results({this.total, this.manga});

  Results.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['manga'] != null) {
      manga = <Manga>[];
      json['manga'].forEach((v) {
        manga?.add(Manga.fromJson(v));
      });
    }
  }
}