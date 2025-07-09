import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/note_model.dart';

class NotesController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final RxList<NoteModel> notes = <NoteModel>[].obs;

  void listenToNotes(String uid) {
    _firestore
        .collection('notes')
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      notes.value = snapshot.docs.map((doc) {
        return NoteModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<void> addNote(NoteModel note) async {
    await _firestore.collection('notes').add({
      ...note.toMap(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateNote(String docId, NoteModel updatedNote) async {
    await _firestore.collection('notes').doc(docId).update(updatedNote.toMap());
  }

  Future<void> deleteNote(String docId) async {
    await _firestore.collection('notes').doc(docId).delete();
  }
}
