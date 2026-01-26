import 'dart:io';

void main() {
  // INPUT KODE LAYANAN
  stdout.write('Masukkan kode layanan (S/E/R/H): ');
  String kode = stdin.readLineSync()!.toUpperCase();

  String namaLayanan;
  String estimasiHari;
  int biayaTambahan;

  // SWITCH PEMETAAN LAYANAN
  switch (kode) {
    case 'S':
      namaLayanan = 'Same Day';
      estimasiHari = '0–1 hari';
      biayaTambahan = 25000;
      break;

    case 'E':
      namaLayanan = 'Express';
      estimasiHari = '1–2 hari';
      biayaTambahan = 15000;
      break;

    case 'R':
      namaLayanan = 'Reguler';
      estimasiHari = '2–4 hari';
      biayaTambahan = 8000;
      break;

    case 'H':
      namaLayanan = 'Hemat';
      estimasiHari = '3–7 hari';
      biayaTambahan = 0;
      break;

    default:
      print('\n❌ Kode layanan tidak dikenal');
      return;
  }

  // OUTPUT
  print('\n===== DETAIL LAYANAN =====');
  print('Layanan        : $namaLayanan');
  print('Estimasi Kirim : $estimasiHari');
  print('Biaya Tambahan : Rp$biayaTambahan');
}