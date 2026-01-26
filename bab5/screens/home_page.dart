import 'package:flutter/material.dart';
import '../models/note.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final List<Note> _notes = List.generate(
    3,
    (i) => Note(id: 'n$i', title: 'Catatan ${i + 1}', content: 'Isi catatan ke-${i + 1}'),
  );
  Future<void> _openAdd() async {
    final result = await Navigator.pushNamed(context, '/edit');
    if (result is Note) {
      setState(() {
        _notes.insert(0, result);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Catatan ditambahkan')));
    }
  }
  Future<void> _openEdit(Note note, int index) async {
    final result = await Navigator.pushNamed(context, '/edit', arguments: note);
    if (result is Note) {
      setState(() {
        _notes[index] = result;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Catatan diperbarui')));
    }
  }
  void _delete(int index) {
    final removed = _notes.removeAt(index);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Dihapus: ${removed.title}'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _notes.insert(index, removed);
            });
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CatatanKu Pro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final q = await showDialog<String>(
                context: context,
                builder: (ctx) {
                  final ctl = TextEditingController();
                  return AlertDialog(
                    title: const Text('Cari catatan'),
                    content: TextField(
                      controller: ctl,
                      decoration: const InputDecoration(hintText: 'Ketik kata kunci'),
                      onSubmitted: (v) => Navigator.of(ctx).pop(v),
                    ),
                    actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Batal'))],
                  );
                },
              );
              if (q != null && q.isNotEmpty) {
                final idx = _notes.indexWhere((n) => n.title.contains(q) || n.content.contains(q));
                if (idx != -1) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ditemukan di posisi ${idx + 1}')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tidak ditemukan')));
                }
              }
            },
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'logout') Navigator.pushReplacementNamed(context, '/');
            },
            itemBuilder: (_) => [const PopupMenuItem(value: 'logout', child: Text('Logout'))],
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: _notes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final note = _notes[index];
          final initials = (note.title.isNotEmpty) ? note.title.trim().split(' ').map((s) => s[0]).take(2).join() : 'C';
          return Dismissible(
            key: ValueKey(note.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.redAccent,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => _delete(index),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(backgroundColor: Colors.blue[700], child: Text(initials, style: const TextStyle(color: Colors.white))),
                title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Text(note.formattedDate, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                isThreeLine: true,
                onTap: () => _openEdit(note, index),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _delete(index),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAdd,
        label: const Text('Tambah'),
        icon: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: const Icon(Icons.info_outline), onPressed: () => showAboutDialog(context: context, applicationName: 'CatatanKu Pro')),
            IconButton(icon: const Icon(Icons.filter_list), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Filter belum diimplementasi')))),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
