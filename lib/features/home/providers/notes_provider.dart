
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thoughts/features/auth/services/auth_service.dart';

final notesStream = Provider((ref) => Supabase.instance.client
    .from('Journals')
    .stream(primaryKey: ['id']).inFilter(
        'user_id', [ref.watch(supabaseProvider).auth.currentUser!.id]));

final journalProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  final journalData = ref.watch(notesStream);
  return journalData;
});
