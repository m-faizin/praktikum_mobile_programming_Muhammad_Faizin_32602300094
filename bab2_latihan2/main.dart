import 'dart:io';

void main() {
  // INPUT DATA
  stdout.write('Masukkan nilai rata-rata: ');
  int nilaiRata2 = int.parse(stdin.readLineSync()!);

  stdout.write('Masukkan pendapatan orang tua (rupiah): ');
  int pendapatanOrtu = int.parse(stdin.readLineSync()!);

  stdout.write('Apakah punya prestasi? (ya/tidak): ');
  String inputPrestasi = stdin.readLineSync()!.toLowerCase();
  bool punyaPrestasi = inputPrestasi == 'ya';

  String tingkatPrestasi = '';
  if (punyaPrestasi) {
    stdout.write('Tingkat prestasi (kota/provinsi/nasional): ');
    tingkatPrestasi = stdin.readLineSync()!.toLowerCase();
  }

  // PROSES SELEKSI (nested if)
  String status;
  String alasan;

  if (nilaiRata2 >= 85) {
    // Nilai memenuhi
    if (punyaPrestasi &&
      (tingkatPrestasi == 'provinsi' || tingkatPrestasi == 'nasional')) {
      status = 'Diterima Penuh';
      alasan = 'Nilai memenuhi dan prestasi minimal tingkat provinsi';
    } else {
      if (pendapatanOrtu < 5000000 ||
        (punyaPrestasi && tingkatPrestasi == 'kota')) {
        status = 'Diterima Parsial';
        alasan = 'Nilai memenuhi dan memenuhi syarat ekonomi atau prestasi tingkat kota';
      } else {
        status = 'Tidak Diterima';
        alasan = 'Nilai cukup tapi pendapatan di atas ambang dan tanpa prestasi memadai';
      }
    }
  } else {
    status = 'Tidak Diterima';
    alasan = 'Nilai rata-rata di bawah 85';
  }

  // OUTPUT HASIL
  print('\n===== HASIL SELEKSI BEASISWA =====');
  print('Status : $status');
  print('Alasan : $alasan');
}
