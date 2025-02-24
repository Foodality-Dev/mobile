import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.geoId,
    required this.createdAt,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.bio,
    required this.rank,
    required this.xp,
    required this.interests,
    required this.major,
    required this.gradYear,
  });

  String? id;
  String geoId;
  Timestamp createdAt;
  String username;
  String firstName;
  String lastName;
  String avatarUrl;
  String bio;
  String rank;
  int xp;
  List interests;
  String major;
  int gradYear;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    geoId: json["geoId"],
    createdAt: Timestamp.fromDate(DateTime.parse(json["createdAt"])),
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    avatarUrl: json["avatarUrl"],
    bio: json["bio"],
    rank: json["rank"],
    xp: json["xp"],
    interests: json["interests"],
    major: json["major"],
    gradYear: json["gradYear"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "geoId": geoId,
    "createdAt": createdAt.toDate().toString(),
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "avatarUrl": avatarUrl,
    "bio": bio,
    "rank": rank,
    "xp": xp,
    "interests": interests,
    "major": major,
    "gradYear": gradYear
  };

  factory UserModel.fromFirebase(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    geoId: json["geoId"],
    createdAt: json["createdAt"],
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    avatarUrl: json["avatarUrl"],
    bio: json["bio"],
    rank: json["rank"],
    xp: json["xp"],
    interests: json["interests"],
    major: json["major"],
    gradYear: json["gradYear"]
  );

  Map<String, dynamic> toFirebase() => { // to remove id field and keep createdAt as Timestamp
    "geoId": geoId,
    "createdAt": createdAt,
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "avatarUrl": avatarUrl,
    "bio": bio,
    "rank": rank,
    "xp": xp,
    "interests": interests,
    "major": major,
    "gradYear": gradYear
  };
}