void main() {
  // a. DATA AQI & ACARA LUAR RUANG
  List<int> aqiMingguan = [45, 72, 110, 95, 160, 140, 48]; // Senin → Minggu
  List<bool> acaraLuarRuang = [false, true, true, false, true, false, false];

  List<String> namaHari = [
    'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
  ];

  // VARIABEL RINGKASAN
  int jumlahBaik = 0;
  int jumlahSedang = 0;
  int jumlahSensitif = 0;
  int jumlahTidakSehat = 0;

  int totalAQI = 0;

  int streakBaik = 0;
  int streakBaikTerpanjang = 0;

  // b. LOOP PROSES HARIAN
  for (int i = 0; i < aqiMingguan.length; i++) {
    int aqi = aqiMingguan[i];
    bool adaAcara = acaraLuarRuang[i];

    String kategori = '';
    String rekomendasi = '-';

    // ===== NESTED IF PENENTUAN KATEGORI =====
    if (aqi <= 50) {
      kategori = 'Baik';
      jumlahBaik++;

      streakBaik++;
      if (streakBaik > streakBaikTerpanjang) {
        streakBaikTerpanjang = streakBaik;
      }
    } else {
      streakBaik = 0;

      if (aqi <= 100) {
        kategori = 'Sedang';
        jumlahSedang++;

        if (adaAcara) {
          rekomendasi = 'Masker dianjurkan';
        }
      } else {
        if (aqi <= 150) {
          kategori = 'Tidak Sehat bagi Kelompok Sensitif';
          jumlahSensitif++;
        } else {
          kategori = 'Tidak Sehat';
          jumlahTidakSehat++;

          // Akhir pekan: Sabtu (5) & Minggu (6)
          if (i == 5 || i == 6) {
            rekomendasi = 'Pertimbangkan di rumah';
          }
        }
      }
    }

    totalAQI += aqi;

    // d. LAPORAN HARIAN
    print('Hari: ${namaHari[i]}');
    print('AQI : $aqi');
    print('Kategori: $kategori');
    print('Rekomendasi: $rekomendasi');
    print('---------------------------');
  }

  // RINGKASAN
  double rataRataAQI = totalAQI / aqiMingguan.length;

  print('\n===== RINGKASAN MINGGUAN =====');
  print('Hari Baik                    : $jumlahBaik');
  print('Hari Sedang                  : $jumlahSedang');
  print('Hari Tidak Sehat Sensitif    : $jumlahSensitif');
  print('Hari Tidak Sehat             : $jumlahTidakSehat');
  print('Rata-rata AQI                : ${rataRataAQI.toStringAsFixed(2)}');
  print('Streak Hari Baik Terpanjang  : $streakBaikTerpanjang hari');
}