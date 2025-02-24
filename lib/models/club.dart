import 'package:cloud_firestore/cloud_firestore.dart';

class ClubModel{
    ClubModel({
      required this.id,
      required this.geoId,
      required this.adminName,
      required this.description,
      required this.meeting,
      required this.members,
      required this.name,
      required this.socials,
      required this.topics,
      required this.createdAt,
      required this.bannerUrl,
      required this.activities,
      required this.careerBoosters
    });

  String? id;
  String? geoId;
  String adminName;
  String description;
  Map<String, dynamic> meeting;
  List<dynamic> members;
  String? name;
  Map<String, dynamic> socials;
  List<dynamic> topics;
  Timestamp? createdAt;
  String? bannerUrl;
  List<dynamic> activities;
  List<dynamic> careerBoosters;

  factory ClubModel.fromJson(Map<String, dynamic> json) => ClubModel(
    id: json["id"],
    geoId: json["geoId"],
    adminName: json["adminName"],
    description: json["description"],
    meeting: json["meeting"],
    members: json["members"],
    name: json["name"],
    socials: json["socials"],
    topics: json["topics"],
    createdAt: Timestamp.fromDate(DateTime.parse(json["createdAt"])),
    bannerUrl: json["bannerUrl"],
    activities: json["activities"],
    careerBoosters: json["careerBoosters"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "geoId": geoId,
    "adminName": adminName,
    "description": description,
    "meeting": meeting,
    "members": members,
    "name": name,
    "socials": socials,
    "topics": topics,
    "createdAt": createdAt?.toDate().toString(),
    "bannerUrl": bannerUrl,
    "activities": activities,
    "careerBoosters": careerBoosters
  };

  factory ClubModel.fromFirebase(Map<String, dynamic> json) => ClubModel(
    id: json["id"],
    geoId: json["geoId"],
    adminName: json["adminName"],
    description: json["description"],
    meeting: json["meeting"],
    members: json["members"],
    name: json["name"],
    socials: json["socials"],
    topics: json["topics"],
    createdAt: json["createdAt"],
    bannerUrl: json["bannerUrl"],
    activities: json["activities"],
    careerBoosters: json["careerBoosters"]
  );

  Map<String, dynamic> toFirebase() => { // to remove id field
    "geoId": geoId,
    "adminName": adminName,
    "description": description,
    "meeting": meeting,
    "members": members,
    "name": name,
    "socials": socials,
    "topics": topics,
    "createdAt": createdAt,
    "bannerUrl": bannerUrl,
    "activities": activities,
    "careerBoosters": careerBoosters
  };
}