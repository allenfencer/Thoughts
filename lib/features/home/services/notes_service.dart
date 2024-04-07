import 'package:supabase_flutter/supabase_flutter.dart';

class NotesService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> createTodaysNote(
      {required String title, required String note}) async {
    await supabase.from('Journals').insert({
      'title': title.trim(),
      'body': note.trim(),
      'user_id': supabase.auth.currentUser!.id,
    });
  }

  Future<void> editNote({
    required String noteId,
    required String title,
    required String note,
  }) async {
    await supabase.from('Journals').update({
      'title': title.trim(),
      'body': note.trim(),
      'user_id': supabase.auth.currentUser!.id
    }).eq('journal_id', noteId);
  }

  Future<void> deleteNote({
    required String noteId,
  }) async {
    await supabase.from('Journals').delete().eq('journal_id', noteId);
  }
}
