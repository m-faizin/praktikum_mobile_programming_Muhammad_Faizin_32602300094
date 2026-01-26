import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CatatanKu',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Masuk')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const SizedBox(height: 8),
          const Text('Selamat Datang', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 24),
          TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 8),
          TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
          Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fungsi lupa belum diimplementasi'))), child: const Text('Lupa password?'))),
          const Spacer(),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage())), child: const Text('Lewati'))),
            const SizedBox(width: 12),
            Expanded(child: ElevatedButton(onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage())), child: const Text('Masuk'))),
          ]),
        ]),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> notes = [
    {'title': 'Belajar Row & Column', 'desc': 'Pahami sumbu utama dan silang, serta Expanded/Flexible.'},
    {'title': 'Button di Flutter', 'desc': 'Filled untuk aksi utama, Outlined untuk sekunder.'},
    {'title': 'Text & Overflow', 'desc': 'Gunakan maxLines + overflow agar rapi.'},
  ];

  void _show(String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  void _openAddSheet() {
    final tCtrl = TextEditingController();
    final dCtrl = TextEditingController();
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (ctx){
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left:16, right:16, top:16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: tCtrl, decoration: const InputDecoration(labelText: 'Judul')),
          const SizedBox(height:8),
          TextField(controller: dCtrl, decoration: const InputDecoration(labelText: 'Deskripsi'), maxLines: 4),
          const SizedBox(height:12),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Batal'))),
            const SizedBox(width:8),
            Expanded(child: ElevatedButton(onPressed: (){
              if(tCtrl.text.trim().isEmpty) { _show('Judul kosong'); return; }
              setState(()=> notes.insert(0, {'title': tCtrl.text.trim(), 'desc': dCtrl.text.trim()}));
              Navigator.of(ctx).pop();
              _show('Item ditambahkan');
            }, child: const Text('Simpan'))),
          ]),
          const SizedBox(height:12),
        ]),
      );
    });
  }

  Widget _card(Map<String,String> it){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:16, vertical:8),
      padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
  Container(width:44, height:44, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.indigo), child: const Icon(Icons.note, color: Colors.white)),
        const SizedBox(width:12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(it['title']!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height:6),
          Text(it['desc']!, maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true, style: const TextStyle(color: Colors.black87)),
        ])),
        const SizedBox(width:8),
        Column(children: [
          IconButton(onPressed: () => _show('Edit: ${it['title']}'), icon: const Icon(Icons.edit)),
          IconButton(onPressed: () => _show('Hapus: ${it['title']}'), icon: const Icon(Icons.delete)),
          IconButton(onPressed: () => _show('Bagikan: ${it['title']}'), icon: const Icon(Icons.share)),
        ]),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CatatanKu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final term = await showDialog<String>(context: context, builder: (ctx){
                final c = TextEditingController();
                return AlertDialog(
                  title: const Text('Cari catatan'),
                  content: TextField(controller: c, decoration: const InputDecoration(hintText: 'Kata kunci')),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Batal')),
                    TextButton(onPressed: () => Navigator.of(ctx).pop(c.text.trim()), child: const Text('Cari')),
                  ],
                );
              });
              if(term!=null && term.isNotEmpty){
                final found = notes.where((n)=> n['title']!.toLowerCase().contains(term.toLowerCase()) || n['desc']!.toLowerCase().contains(term.toLowerCase())).toList();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ditemukan ${found.length} item untuk "${term}"')));
              }
            },
            tooltip: 'Cari',
          ),
          PopupMenuButton<String>(
            onSelected: (v){
              if(v=='logout') Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
            },
            itemBuilder: (_)=> const [
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top:12, bottom:80),
        itemCount: notes.length,
        itemBuilder: (_,i) => _card(notes[i]),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _openAddSheet, child: const Icon(Icons.add)),
    );
  }
}
