import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/model/user_model.dart';

class FireBaseFunctions {
  static CollectionReference<TaskModel> getTasksCollections() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addTasksToFire(TaskModel task) {
    var collection = getTasksCollections();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasksFromFire(DateTime dateTime) {
    var collection = getTasksCollections();
    return collection.where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollections().doc(id).delete();
  }

  static Future<void> updateTask(String id, TaskModel taskModel) {
    return getTasksCollections().doc(id).update(taskModel.toJson());
  }

  static CollectionReference<UserModel> getUsersCollections() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addUserToFirestore(UserModel userModel) {
    var collection = getUsersCollections();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  //create account in Authentication
  static Future<void> createAccount(String name, int age, String email,
      String password, Function created) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
          name: name, email: email, age: age, id: credential.user!.uid);

      addUserToFirestore(userModel).then((value) {
        created();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> userSnap =
        await getUsersCollections().doc(id).get();
    return userSnap.data();
  }

  static Future<void> login(
      String email, String password, Function onError, Function logged) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      logged();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError(e.message);
      } else if (e.code == 'wrong-password') {
        onError(e.message);
      }
    }
  }
}
