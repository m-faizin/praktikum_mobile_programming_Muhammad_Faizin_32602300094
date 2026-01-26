import 'package:flutter/material.dart';
import '../models/note.dart';
class EditNotePage extends StatefulWidget {
  const EditNotePage({Key? key}) : super(key: key);
  @override
  State<EditNotePage> createState() => _EditNotePageState();
}
class _EditNotePageState extends State<EditNotePage> {
  late final TextEditingController _titleCtl;
  late final TextEditingController _contentCtl;
  Note? _note;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Note) {
      _note = args;
      _titleCtl = TextEditingController(text: _note!.title);
      _contentCtl = TextEditingController(text: _note!.content);
    } else {
      _note = null;
      _titleCtl = TextEditingController();
      _contentCtl = TextEditingController();
    }
  }
  @override
  void dispose() {
    _titleCtl.dispose();
    _contentCtl.dispose();
    super.dispose();
  }
  void _save() {
    final title = _titleCtl.text.trim();
    final content = _contentCtl.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Judul wajib diisi')));
      return;
    }
    final note = _note == null
        ? Note(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title, content: content)
        : _note!.copyWith(title: title, content: content);
    Navigator.of(context).pop(note);
  }
  @override
  Widget build(BuildContext context) {
    final isEdit = _note != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Catatan' : 'Tambah Catatan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleCtl,
                  decoration: const InputDecoration(labelText: 'Judul', hintText: 'Judul singkat'),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: TextField(
                    controller: _contentCtl,
                    decoration: const InputDecoration(labelText: 'Isi', alignLabelWithHint: true),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    onSubmitted: (_) => _save(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: _save, child: const Text('Simpan')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
