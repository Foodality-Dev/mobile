import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  EventModel(
    {
      required this.id,
      required this.geoId,
      required this.club,
      required this.createdAt,
      required this.scheduledAt,
      required this.name, 
      required this.description,
      required this.joinedUsers,
      required this.attendees,
      required this.type,
      required this.topics,
      required this.xp,
      required this.specialPerks,
      required this.careerBoosters,
      required this.location
    }
  );

  String? id; // only ? because UserModel has the same thing
  String geoId;
  Map<String, dynamic> club; // club admin name, club id, club name
  Timestamp createdAt;
  Timestamp scheduledAt;
  String name;
  String description;
  List<dynamic> joinedUsers;
  List<dynamic> attendees;
  String type; // have this as a well-defined list of types
  List<dynamic> topics; // have this as a well-defined list of topics
  int xp;
  List<dynamic> specialPerks;
  List<dynamic> careerBoosters;
  String location;


  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["id"],
    geoId: json["geoId"],
    club: json["club"],
    createdAt: Timestamp.fromDate(DateTime.parse(json["createdAt"])),
    scheduledAt: Timestamp.fromDate(DateTime.parse(json["scheduledAt"])),
    name: json["name"],
    description: json["description"],
    joinedUsers: json["joinedUsers"],
    attendees: json["attendees"],
    type: json["type"],
    topics: json["topics"],
    xp: json["xp"],
    specialPerks: json["specialPerks"],
    careerBoosters: json["careerBoosters"],
    location: json["location"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "geoId": geoId,
    "club": club,
    "createdAt": createdAt.toDate().toString(),
    "scheduledAt": scheduledAt.toDate().toString(),
    "name": name,
    "description": description,
    "joinedUsers": joinedUsers,
    "attendees": attendees,
    "type": type,
    "topics": topics,
    "xp": xp,
    "specialPerks": specialPerks,
    "careerBoosters": careerBoosters,
    "location": location
  };

  factory EventModel.fromFirebase(Map<String, dynamic> json) => EventModel(
    id: json["id"],
    geoId: json["geoId"],
    club: json["club"],
    createdAt: json["createdAt"],
    scheduledAt: json["scheduledAt"],
    name: json["name"],
    description: json["description"],
    joinedUsers: json["joinedUsers"],
    attendees: json["attendees"],
    type: json["type"],
    topics: json["topics"],
    xp: json["xp"],
    specialPerks: json["specialPerks"],
    careerBoosters: json["careerBoosters"],
    location: json["location"]
  );

  Map<String, dynamic> toFirebase() => { // to remove id field
    "geoId": geoId,
    "club": club,
    "createdAt": createdAt,
    "scheduledAt": scheduledAt,
    "name": name,
    "description": description,
    "joinedUsers": joinedUsers,
    "attendees": attendees,
    "type": type,
    "topics": topics,
    "xp": xp,
    "specialPerks": specialPerks,
    "careerBoosters": careerBoosters,
    "location" : location
  };
}