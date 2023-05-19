import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/task_model.dart';

class FireBaseFunctions {
  static CollectionReference<TaskModel> getTasksCollections() {
    return  FirebaseFirestore.instance
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
  static Stream<QuerySnapshot<TaskModel>> getTasksFromFire(DateTime dateTime){
    var collection = getTasksCollections();
    return collection.where("date",isEqualTo:DateUtils.dateOnly(dateTime).millisecondsSinceEpoch ).snapshots();
  }
  static Future<void> deleteTask(String id){
    return getTasksCollections().doc(id).delete();
  }
  static Future<void> updateTask(String id,TaskModel taskModel){
    return getTasksCollections().doc(id).update(taskModel.toJson());
  }
}
