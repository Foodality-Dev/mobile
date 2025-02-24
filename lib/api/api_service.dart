import 'dart:io';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/event.dart';
// import '../models/goal.dart';
import '../models/task.dart';
import '../models/user.dart';

class ApiService {
  final firebaseDB = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  // BEGIN GEOCOMMUNITY, EVENT, CLUB API FUNCTIONS
  Future<Map<String, dynamic>> getGeocommunity(String? geoId) {
    return firebaseDB.collection('geocommunities').doc(geoId)
      .get()
      .then((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = geoId;
        return data;
      });
  }
  
  // Future<void> addUsername(String? username, String? uid) {
  //   return firebaseDB
  //       .collection("usernames")
  //       .add({"userId" : uid})
  //       .then((value) => log("username added"))
  //       .catchError((onError) => log("Failed to add username: $onError"));
  // }

  Future<EventModel> getEvent(String? eventId) {
    return firebaseDB.collection('events').doc(eventId)
      .get()
      .then((DocumentSnapshot doc) {
        Map<String, dynamic> rawEvent = doc.data() as Map<String, dynamic>;
        rawEvent["id"] = doc.id;
        EventModel event = EventModel.fromFirebase(rawEvent);
        return event;
      });
  }

  // TODO alter so it accepts filters.. probably through optional parameters
  // Stream<QuerySnapshot> getGeoEvents(String? geoId) {
  //   return firebaseDB.collection("events")
  //     .where("geoId", isEqualTo: geoId)
  //     .where("scheduledAt", isGreaterThanOrEqualTo: Timestamp.now())
  //     .orderBy("scheduledAt")
  //     .snapshots();
  // }
  Future<QuerySnapshot> getGeoEvents(String? geoId) {
    return firebaseDB.collection("events")
      .where("geoId", isEqualTo: geoId)
      .where("scheduledAt", isGreaterThanOrEqualTo: Timestamp.now())
      .orderBy("scheduledAt")
      .get();
  }

  Future<QuerySnapshot> getGeoEventsFromCache(String? geoId) {
    return firebaseDB.collection("events")
      .where("geoId", isEqualTo: geoId)
      .where("scheduledAt", isGreaterThanOrEqualTo: Timestamp.now())
      .orderBy("scheduledAt")
      .get(const GetOptions(source: Source.cache));
  }

  Future<QuerySnapshot> getUserClubs(String? userId) {
    return firebaseDB.collection('clubs')
      .where("members", arrayContains: userId)
      .get();
  }
  Stream<QuerySnapshot> getUserEvents(String? userId) {
    return firebaseDB.collection("events")
      .where("joinedUsers", arrayContains: userId)
      .where("scheduledAt", isGreaterThanOrEqualTo: Timestamp.now())
      .orderBy("scheduledAt")
      .snapshots();
  }

  Stream<QuerySnapshot> getClubEvents(String? geoId, String? clubId) {
    return firebaseDB.collection("events")
      .where("geoId", isEqualTo: geoId)
      .where("club.id", isEqualTo: clubId)
      .where("scheduledAt", isGreaterThanOrEqualTo: Timestamp.now())
      .limit(2)
      .snapshots();
  }

  Future<void> updateEvent(EventModel event) {
    final payload = event.toFirebase();
    return firebaseDB.collection("events")
      .doc(event.id)
      .update(payload)
      .then((value) => log("Event ${event.id} updated"))
      .catchError((onError) => log("Failed to update event ${event.id}: $onError"));
  }

  Future<QuerySnapshot> getAttendedEvents(String? userId) {
    return firebaseDB.collection('events')
      .where("attendees", arrayContains: userId)
      .get();
  }

  Future<DocumentSnapshot> getClubInfo(String? clubId) {
    return firebaseDB.collection("clubs")
      .doc(clubId)
      .get();
  }
  // END GEOCOMMUNITY API FUNCTIONS

  Future<UserModel> getUser(String? userId) {
    return firebaseDB.collection('users').doc(userId)
      .get()
      .then((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = userId;
        UserModel user = UserModel.fromFirebase(data);
        return user;
      });
  }

  Future<void> addUser(UserModel user) {
    // https://stackoverflow.com/questions/48541270/how-to-add-document-with-custom-id-to-firestore

    firebaseDB.collection("usernames")
        .doc(user.username.toLowerCase())
        .set({"userId" : user.id})
        .then((value) => log("Username added"))
        .catchError((onError) => log("Failed to add username: $onError"));

    return firebaseDB.collection("users")
      .doc(user.id)
      .set(user.toFirebase())
      .then((value) => log("User added"))
      .catchError((onError) => log("Failed to add user: $onError"));
  }

  Future<void> updateUser(String? id, Map<String, dynamic> payload) async {
    QuerySnapshot querySnapshot = await firebaseDB.collection('usernames')
        .where('userId', isEqualTo: id)
        .get();

    for (var element in querySnapshot.docs) {
      firebaseDB.collection("usernames")
          .doc(payload["username"].toLowerCase())
          .set({"userId" : id!})
          .then((value) => log("Username updated"))
          .catchError((onError) => log("Failed to update username: $onError"));

      element.reference.delete();
    }

    return firebaseDB.collection("users")
      .doc(id)
      .update(payload)
      .then((value) => log("User $id updated"))
      .catchError((onError) => log("Failed to update user $id: $onError"));
  }

  // https://stackoverflow.com/questions/68073767/how-to-enforce-uniqueness-in-a-property-of-a-document-field-in-google-cloud-fire
  Future<bool> isUsernameUnique(String username) async {
    final firebaseDB = FirebaseFirestore.instance;
    var user = await firebaseDB.collection("usernames")
        .doc(username.toLowerCase())
        .get();

    return !user.exists;
  }

  Future<bool> isEmailRegistered(String? email) async {
    List<String> signInMethods = await firebaseAuth.fetchSignInMethodsForEmail(email != null ? email : 'placeholder');
    return signInMethods.isNotEmpty;
  }

  // Stream<QuerySnapshot> getGoals(String? userId) {
  //   return firebaseDB.collection("goals")
  //     .where('userId', isEqualTo: userId)
  //     .snapshots();
  // }

  // Future<QuerySnapshot> getGoal(String? userId) {
  //   return firebaseDB.collection("goals")
  //       .where("userId", isEqualTo: userId)
  //       .get();
  // }

  // Future<void> addGoal(String goalName, String? userId) {
  //   final firebaseDB = FirebaseFirestore.instance;
  //   return firebaseDB
  //       .collection("goals")
  //       .add({
  //         "createdAt": Timestamp.fromDate(DateTime.now()),
  //         "points": 2, // hard coded
  //         "state": "incomplete", // hard coded
  //         "title": goalName,
  //         "userId": userId
  //       })
  //       .then((value) => log("Task added"))
  //       .catchError((onError) => log("Failed to add task: $onError"));
  // }
  // Future<void> addGoal(GoalModel goal) {
  //   return firebaseDB
  //       .collection("goals")
  //       .add(goal.toFirebase())
  //       .then((value) => log("Task added"))
  //       .catchError((onError) => log("Failed to add task: $onError"));
  // }

  // Future<void> updateGoal(String goalId, Map<String, String> payload) {
  //   return firebaseDB
  //       .collection("goals")
  //       .doc(goalId)
  //       .update(payload)
  //       .then((value) => log("Goal $goalId updated"))
  //       .catchError((onError) => log("Failed to update goal $goalId: $onError"));
  // }

  // imo, using GoalModel for updating a goal results in unnecessary work and is a performance drawback

  // Future<void> updateGoal(GoalModel goal) {
  //   final firebaseDB = FirebaseFirestore.instance;
  //   return firebaseDB
  //       .collection("goals")
  //       .doc(goal.id)
  //       .update(goal.toFirebase())
  //       .then((value) => log("Goal ${goal.id} updated"))
  //       .catchError(
  //           (onError) => log("Failed to update goal ${goal.id}: $onError"));
  // }

  // https://firebase.flutter.dev/docs/firestore/usage/
  // https://firebase.google.com/docs/firestore/query-data/queries
  Stream<QuerySnapshot> getTasks(String goalId) {
    return firebaseDB
        .collection("tasks")
        .where("goalId", isEqualTo: goalId)
        .snapshots();
  }

  Future<AggregateQuerySnapshot> getTaskCount(String goalId) {
    return firebaseDB
        .collection("tasks")
        .where("goalID", isEqualTo: goalId)
        .count()
        .get();
  }

  Future<int> getUserIdCount(String userId) async {
    int matches = -1;
    
    await firebaseDB
      .collection('usernames')
      .where("userId", isEqualTo: userId)
      .count()
      .get()
      .then((result)=> matches = result as int);

      return matches;
  }

  Future<void> addTask(TaskModel task) {
    return firebaseDB.collection("tasks")
      .add(task.toFirebase())
      .then((value) => log("Task added"))
      .catchError((onError) => log("Failed to add task: $onError"));
  }

    // imo, using TaskModel for updating a goal results in unnecessary work and is a performance drawback

  // Future<void> updateTask(TaskModel task) {
  //   final firebaseDB = FirebaseFirestore.instance;
  //   return firebaseDB.collection("tasks")
  //     .doc(task.id)
  //     .update(task.toFirebase())
  //     .then((value) => log("Task ${task.id} updated"))
  //     .catchError((onError) => log("Failed to update task ${task.id}: $onError"));
  // }

  // Stream<QuerySnapshot> getNewEvents() {
  //   final firebaseDB = FirebaseFirestore.instance;
  //   return firebaseDB.collection("events")
  //     .where("attendees", )
  // }
  
  Future<void> updateTask(String id, Map<String, String> payload) {
    return firebaseDB.collection("tasks")
      .doc(id)
      .update(payload)
      .then((value) => log("Task $id updated"))
      .catchError((onError) => log("Failed to update task $id: $onError"));
  }

  Future<void> deleteTask(String id) {
    return firebaseDB.collection("tasks")
      .doc(id)
      .delete()
      .then((value) => log("Task $id deleted"))
      .catchError((onError) => log("Failed to delete task $id: $onError"));
  }

  Future<AggregateQuerySnapshot> getTasksCompletedCount(String? userId) {
    return firebaseDB.collection("tasks")
      .where("userId", isEqualTo: userId)
      .count()
      .get();
  }

  Future<void> deleteUser(String? id) async {
    QuerySnapshot querySnapshot = await firebaseDB.collection('usernames')
        .where('userId', isEqualTo: id)
        .get();
    
    for (var element in querySnapshot.docs) {
      element.reference.delete();
    }

    return firebaseDB.collection("users")
      .doc(id)
      .delete()
      .then((value) => log("User $id deleted"))
      .catchError((onError) => log("Failed to delete user $id: $onError"));
  }

  // Future<void> deleteUsername(String? id) async{
  
  //   QuerySnapshot querySnapshot = await firebaseDB
  //     .collection('usernames')
  //     .where('userId', isEqualTo: id)
  //     .get();
  //   print('in delete username');
  //   querySnapshot.docs.forEach((element) {
  //     print(element);
  //     element.reference.delete();
  //   });
  // }

  Future<void> removeUserFromAttendees(String? id) async {

    QuerySnapshot querySnapshot = await firebaseDB
      .collection('events')
      .where('attendees', arrayContains: id)
      .get();
    
    print('removing: $id from attendees');
    
    for (var element in querySnapshot.docs) {
      // print(element);
      // element.reference.delete();
      firebaseDB
      .collection('events')
      .doc(element.id)
      .update({
        'attendees' : FieldValue.arrayRemove([id])
      });
    }
  }

  Future<void> removeUserFromAllJoinedEvents(String? id) async {

    QuerySnapshot querySnapshot = await firebaseDB
      .collection('events')
      .where('joinedUsers', arrayContains: id)
      .get();
    
    print('removing: $id from joinedUsers');
    
    for (var element in querySnapshot.docs) {
      // print(element);
      // element.reference.delete();
      firebaseDB
      .collection('events')
      .doc(element.id)
      .update({
        'joinedUsers': FieldValue.arrayRemove([id])
      });
    }
  }

  Future<void> removeUserFromJoinedEvent(String? eventId, String? userId) async {
    await firebaseDB
      .collection('events')
      .doc(eventId)
      .update({
        'joinedUsers': FieldValue.arrayRemove([userId])
      })
      .then((value) {
        print('success removing user $userId from event $eventId');
      },)
      .catchError((err) {
        print('there was an error removing user $userId from event $eventId. Error message: $err');
      });
  }
}



Future<String> uploadImage(File? image, String userId) async {
  // Create a storage reference from our app
  final storageRef = FirebaseStorage.instance.ref();

  // Create a reference to 'images/avatars/<USER_EMAIL>.png'
  final avatarImagesRef = storageRef.child("images/avatars/$userId.png");

  // Upload image!
  if (image != null) await avatarImagesRef.putFile(image);

  // Set the class variable. Not returning it
  return avatarImagesRef.getDownloadURL();
}