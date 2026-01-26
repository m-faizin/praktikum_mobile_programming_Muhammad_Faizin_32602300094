import 'dart:io';

void main() {
  // ==============================
  // KONSTANTA (const)
  // ==============================
  const double hargaEspresso = 18000;
  const double hargaLatte = 22000;
  const double hargaTeh = 12000;
  const double tarifPajak = 0.10;

  // ==============================
  // FINAL (timestamp cetak struk)
  // ==============================
  final DateTime waktuCetak = DateTime.now();

  // ==============================
  // INPUT JUMLAH GELAS (int)
  // ==============================
  stdout.write('Masukkan jumlah Espresso: ');
  int qtyEspresso = int.parse(stdin.readLineSync()!);

  stdout.write('Masukkan jumlah Latte: ');
  int qtyLatte = int.parse(stdin.readLineSync()!);

  stdout.write('Masukkan jumlah Teh: ');
  int qtyTeh = int.parse(stdin.readLineSync()!);

  // ==============================
  // PERHITUNGAN (double)
  // ==============================
  double subtotalEspresso = qtyEspresso * hargaEspresso;
  double subtotalLatte = qtyLatte * hargaLatte;
  double subtotalTeh = qtyTeh * hargaTeh;

  double subtotal = subtotalEspresso + subtotalLatte + subtotalTeh;
  double pajak = subtotal * tarifPajak;
  double totalAkhir = subtotal + pajak;

  // ==============================
  // OUTPUT RINGKASAN STRUK
  // ==============================
  print('\n===== STRUK KOPI KITA =====');
  print('Espresso : $qtyEspresso x Rp${hargaEspresso.toStringAsFixed(0)}');
  print('Latte    : $qtyLatte x Rp${hargaLatte.toStringAsFixed(0)}');
  print('Teh      : $qtyTeh x Rp${hargaTeh.toStringAsFixed(0)}');

  print('---------------------------');
  print('Subtotal : Rp${subtotal.toStringAsFixed(0)}');
  print('Pajak 10%: Rp${pajak.toStringAsFixed(0)}');
  print('Total    : Rp${totalAkhir.toStringAsFixed(0)}');

  print('---------------------------');
  print('Waktu Cetak: $waktuCetak');
  print('Terima kasih telah berkunjung');
}
