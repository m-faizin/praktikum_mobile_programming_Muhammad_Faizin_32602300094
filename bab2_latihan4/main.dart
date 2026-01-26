import 'dart:io';

void main() {
  // a. Inisialisasi List penjualan
  List<int> penjualan = [5, 3, 7, 6, 2, 5, 1, 3];

  // b. FOR → total & rata-rata
  int total = 0;
  for (int i = 0; i < penjualan.length; i++) {
    total += penjualan[i];
  }
  double rataRata = total / penjualan.length;

  // c. WHILE → cari min & max
  int min = penjualan[0];
  int max = penjualan[0];
  int index = 1;

  while (index < penjualan.length) {
    if (penjualan[index] < min) {
      min = penjualan[index];
    }
    if (penjualan[index] > max) {
      max = penjualan[index];
    }
    index++;
  }

  // d. DO-WHILE → tambah transaksi
  String ulangi;
  do {
    stdout.write('\nMasukkan jumlah buku terjual: ');
    int transaksiBaru = int.parse(stdin.readLineSync()!);

    if (transaksiBaru >= 0) {
      penjualan.add(transaksiBaru);
    }

    stdout.write('Tambah transaksi lagi? (y/n): ');
    ulangi = stdin.readLineSync()!.toLowerCase();
  } while (ulangi == 'y');

  // Hitung ulang setelah penambahan
  total = 0;
  for (int i = 0; i < penjualan.length; i++) {
    total += penjualan[i];
  }
  rataRata = total / penjualan.length;

  min = penjualan[0];
  max = penjualan[0];
  index = 1;

  while (index < penjualan.length) {
    if (penjualan[index] < min) min = penjualan[index];
    if (penjualan[index] > max) max = penjualan[index];
    index++;
  }

  // e. Ringkasan & 3 transaksi terakhir
  int jumlahTransaksi = penjualan.length;

  List<int> tigaTerakhir = jumlahTransaksi >= 3
      ? penjualan.sublist(jumlahTransaksi - 3)
      : penjualan;

  print('\n===== RINGKASAN PENJUALAN =====');
  print('Jumlah Transaksi     : $jumlahTransaksi');
  print('Total Buku terjual   : $total');
  print('Rata-rata            : ${rataRata.toStringAsFixed(2)}');
  print('Minimum              : $min');
  print('Maksimum             : $max');
  print('3 Transaksi Terakhir : $tigaTerakhir');
}