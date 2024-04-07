import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thoughts/features/home/services/notes_service.dart';
import 'package:thoughts/utils/themes/themes.dart';

class NoteScreen extends StatefulWidget {
  final bool updateNote;
  final String? noteId;
  final String? title;
  final String? body;
  const NoteScreen(
      {super.key,
      required this.updateNote,
      this.title,
      this.body,
      this.noteId});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final formattedDate = DateFormat('E, MMMM d y').format(DateTime.now());
  late TextEditingController titleController =
      TextEditingController.fromValue(TextEditingValue(text: formattedDate));
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.updateNote) {
      titleController.text = widget.title ?? '';
      notesController.text = widget.body ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandWhite,
      appBar: AppBar(
        backgroundColor: AppColors.brandWhite,
        title: TextField(
          maxLines: 1,
          controller: titleController,
          style: TT.f16w600,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(border: InputBorder.none),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (widget.updateNote) {
                  await NotesService().editNote(
                      noteId: widget.noteId!,
                      note: notesController.text,
                      title: titleController.text);
                } else {
                  await NotesService().createTodaysNote(
                      note: notesController.text, title: titleController.text);
                }
                if (context.mounted) {
                  context.pop();
                }
              },
              icon: const Icon(Icons.check_circle_outline_rounded))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: 9999,
                controller: notesController,
                style: TT.f16w400,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Start crafting your beautiful life stories',
                  hintStyle: TT.f16w500,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
