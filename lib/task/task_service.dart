import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _userId => _auth.currentUser!.uid;

  CollectionReference get _tasksCollection =>
      _firestore.collection('users').doc(_userId).collection('tasks');

  Stream<List<Task>> getTasks() {
    return _tasksCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
        });
  }

  Future<void> addTask(Task task) async {
    await _tasksCollection.add(task.toMap());
  }

  Future<void> updateTask(Task task) async {
    await _tasksCollection.doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    await _tasksCollection.doc(taskId).delete();
  }

  Future<void> toggleTaskComplete(String taskId, bool completed) async {
    await _tasksCollection.doc(taskId).update({'completed': !completed});
  }
}
