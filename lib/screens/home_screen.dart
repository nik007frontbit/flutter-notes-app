import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notes_controller.dart';
import '../controllers/auth_controller.dart';
import '../models/note_model.dart';

class HomeScreen extends StatelessWidget {
  final notesController = Get.put(NotesController());
  final authController = AuthController.to;

  final titleController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String uid = authController.firebaseUser.value?.uid ?? '';
    notesController.listenToNotes(uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: authController.logout,
          ),
        ],
      ),
      body: Obx(() {
        if (notesController.notes.isEmpty) {
          return const Center(child: Text('No notes found'));
        }
        return ListView.separated(
          itemCount: notesController.notes.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, index) {
            final note = notesController.notes[index];
            return _buildNoteTile(note, uid);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(uid),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteTile(NoteModel note, String uid) {
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.message),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => _showNoteDialog(uid, isEdit: true, note: note),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmDelete(note.id),
          ),
        ],
      ),
    );
  }

  void _showNoteDialog(String uid, {bool isEdit = false, NoteModel? note}) {
    if (isEdit && note != null) {
      titleController.text = note.title;
      messageController.text = note.message;
    } else {
      titleController.clear();
      messageController.clear();
    }

    Get.defaultDialog(
      title: isEdit ? 'Update Note' : 'New Note',
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: messageController,
            decoration: const InputDecoration(labelText: 'Message'),
          ),
        ],
      ),
      textConfirm: isEdit ? 'Update' : 'Save',
      confirmTextColor: Colors.white,
      onConfirm: () {
        final title = titleController.text.trim();
        final message = messageController.text.trim();
        if (title.isEmpty || message.isEmpty) {
          Get.snackbar('Error', 'Both fields are required');
          return;
        }

        if (isEdit && note != null) {
          notesController.updateNote(note.id, NoteModel(
            id: note.id,
            title: title,
            message: message,
            uid: uid,
          ));
        } else {
          notesController.addNote(NoteModel(
            title: title,
            message: message,
            uid: uid,
          ));
        }

        Get.back();
      },
      textCancel: 'Cancel',
    );
  }

  void _confirmDelete(String noteId) {
    Get.defaultDialog(
      title: 'Delete Note',
      middleText: 'Are you sure you want to delete this note?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        notesController.deleteNote(noteId);
        Get.back();
      },
    );
  }
}
