import 'dart:io';

void main() {
  // INPUT DATA
  stdout.write('Masukkan usia pengunjung: ');
  int usia = int.parse(stdin.readLineSync()!);

  stdout.write('Apakah hari akhir pekan? (ya/tidak): ');
  bool isAkhirPekan = stdin.readLineSync()!.toLowerCase() == 'ya';

  stdout.write('Apakah punya MemberCard? (ya/tidak): ');
  bool punyaMember = stdin.readLineSync()!.toLowerCase() == 'ya';

  // HARGA DASAR
  const int hargaPelajar = 30000;
  const int hargaDewasa = 50000;
  const int hargaLansia = 40000;

  String kategori = '';
  double hargaAwal = 0;
  double hargaSetelahAkhirPekan = 0;
  double diskonMember = 0;
  double totalAkhir = 0;

  // NESTED IF
  if (usia < 6) {
    // GRATIS
    kategori = 'Anak-anak';
    hargaAwal = 0;
    hargaSetelahAkhirPekan = 0;
    totalAkhir = 0;
  } else {
    // TENTUKAN KATEGORI USIA
    if (usia >= 6 && usia <= 17) {
      kategori = 'Pelajar';
      hargaAwal = hargaPelajar.toDouble();
    } else {
      if (usia >= 18 && usia <= 60) {
        kategori = 'Dewasa';
        hargaAwal = hargaDewasa.toDouble();
      } else {
        kategori = 'Lansia';
        hargaAwal = hargaLansia.toDouble();
      }
    }

    // AKHIR PEKAN +20%
    hargaSetelahAkhirPekan = hargaAwal;
    if (isAkhirPekan) {
      hargaSetelahAkhirPekan = hargaAwal * 1.2;
    }

    // DISKON MEMBER 10%
    totalAkhir = hargaSetelahAkhirPekan;
    if (punyaMember) {
      diskonMember = totalAkhir * 0.10;
      totalAkhir = totalAkhir - diskonMember;
    }

    // MINIMUM CHARGE 30.000
    if (totalAkhir < 30000) {
      totalAkhir = 30000;
    }
  }

  // OUTPUT RINCIAN
  print('\n===== RINCIAN TIKET SERULAND =====');
  print('Kategori           : $kategori');
  if (isAkhirPekan) {
    print('Harga Akhir Pekan  : Rp${hargaSetelahAkhirPekan.toStringAsFixed(0)}');
  } else {
    print('Harga Hari Kerja   : Rp${hargaAwal.toStringAsFixed(0)}');
  }
  if (punyaMember) {
    print('Diskon Member      : Rp${diskonMember.toStringAsFixed(0)}');
  }
  print('Total Akhir        : Rp${totalAkhir.toStringAsFixed(0)}');
}