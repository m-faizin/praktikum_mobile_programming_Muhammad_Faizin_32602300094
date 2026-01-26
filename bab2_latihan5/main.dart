import 'dart:io';

void main() {
  stdout.writeln('GudangGawai - Manajemen Stok Sederhana');

  // a) Map data: kode -> {nama, stok, harga}
  final Map<String, Map<String, Object>> katalog = {
    'A01': {'nama': 'Earphone', 'stok': 12, 'harga': 99000},
    'A02': {'nama': 'Powerbank', 'stok': 5, 'harga': 250000},
    'A03': {'nama': 'Charger', 'stok': 20, 'harga': 45000},
    'A04': {'nama': 'Headphone', 'stok': 7, 'harga': 350000},
    'A05': {'nama': 'Mouse', 'stok': 30, 'harga': 200000},
  };

  while (true) {
    stdout.writeln('\nMenu:\n1) Cari barang\n2) Update stok\n3) List barang mahal (>200000)\n4) Cetak semua kode & nama\n5) Keluar');
    stdout.write('Pilih opsi (1-5): ');
    final String? optLine = stdin.readLineSync();
    if (optLine == null) break;
    final opt = optLine.trim();
    if (opt == '5') break;

    switch (opt) {
      case '1':
        _cariBarang(katalog);
        break;
      case '2':
        _updateStok(katalog);
        break;
      case '3':
        _listBarangMahal(katalog);
        break;
      case '4':
        _cetakKodeNama(katalog);
        break;
      default:
        stdout.writeln('Opsi tidak dikenal.');
    }
  }

  stdout.writeln('Keluar. Terima kasih.');
}

void _cariBarang(Map<String, Map<String, Object>> katalog) {
  stdout.write('Masukkan kode barang: ');
  final kode = stdin.readLineSync()?.trim().toUpperCase() ?? '';
  if (!katalog.containsKey(kode)) {
    stdout.writeln('Kode tidak ditemukan: $kode');
    return;
  }
  final item = katalog[kode]!;
  stdout.writeln('Detail $kode:');
  stdout.writeln('Nama: ${item['nama']}');
  stdout.writeln('Stok: ${item['stok']}');
  stdout.writeln('Harga: Rp${_formatRupiah(item['harga'] as int)}');
}

void _updateStok(Map<String, Map<String, Object>> katalog) {
  stdout.write('Masukkan kode barang untuk update stok: ');
  final kode = stdin.readLineSync()?.trim().toUpperCase() ?? '';
  if (!katalog.containsKey(kode)) {
    stdout.writeln('Kode tidak ditemukan: $kode');
    return;
  }
  stdout.write('Masukkan perubahan stok (positif menambah, negatif mengurangi): ');
  final line = stdin.readLineSync();
  final change = int.tryParse(line?.trim() ?? '');
  if (change == null) {
    stdout.writeln('Input tidak valid.');
    return;
  }
  final current = katalog[kode]!['stok'] as int;
  final updated = current + change;
  if (updated < 0) {
    stdout.writeln('Update ditolak. Stok tidak boleh negatif.');
    return;
  }
  katalog[kode]!['stok'] = updated;
  stdout.writeln('Stok $kode berhasil diupdate: $current -> $updated');
}

void _listBarangMahal(Map<String, Map<String, Object>> katalog) {
  stdout.writeln('\nDaftar barang dengan harga > Rp200.000:');
  bool found = false;
  katalog.forEach((kode, item) {
    final harga = item['harga'] as int;
    if (harga > 200000) {
      found = true;
      stdout.writeln('- $kode : ${item['nama']} (Rp${_formatRupiah(harga)}) - Stok: ${item['stok']}');
    }
  });
  if (!found) stdout.writeln('Tidak ada barang dengan harga di atas Rp200.000');
}

void _cetakKodeNama(Map<String, Map<String, Object>> katalog) {
  stdout.writeln('\nSemua kode barang:');
  stdout.writeln(katalog.keys.join(', '));
  stdout.writeln('\nSemua nama barang:');
  stdout.writeln(katalog.values.map((v) => v['nama']).join(', '));
}

String _formatRupiah(int value) {
  final s = value.toString();
  final buffer = StringBuffer();
  int len = s.length;
  int count = 0;
  for (int i = len - 1; i >= 0; i--) {
    buffer.write(s[i]);
    count++;
    if (count == 3 && i != 0) {
      buffer.write('.');
      count = 0;
    }
  }
  return buffer.toString().split('').reversed.join();
}
