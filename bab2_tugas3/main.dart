import 'dart:io';
void main(){
  stdout.writeln('Minimarket Hemart - Kasir');
  var K = {
    'M01':{'nama':'Air Mineral 600ml', 'kat':'minuman', 'h':5000, 's':40},
    'M02':{'nama':'Teh Botol', 'kat':'minuman', 'h':8000, 's':10},
    'S01':{'nama':'Keripik Kentang', 'kat':'snack', 'h':12000, 's':5},
    'S02':{'nama':'Wafer', 'kat':'snack', 'h':15000, 's':30},
    'H01':{'nama':'Sabun Mandi', 'kat':'home', 'h':9000,'s':30}
  };
  var member = yn('Member Hemart? (y/n) ');
  var cart = <String,int>{};
  stdout.writeln('\nMasukkan item. "selesai" untuk selesai, "produk" untuk lihat produk, "cari <kata>" untuk cari.');
  while(true){
    var raw = r('\nKode (mis. M01) / perintah: ').trim();
    if(raw.toLowerCase()=='selesai') break;
    if(raw.isEmpty) continue;
    var low=raw.toLowerCase();
    if(low=='produk'||low=='list'){printK(K);continue;}
    String code='';
    if(low.startsWith('cari ')){
      var term=raw.substring(5).trim();
      var m=search(K,term);
      if(m.isEmpty){stdout.writeln('Tidak ditemukan untuk "$term"');continue;}
      if(m.length==1){code=m.first; stdout.writeln('Pilih: $code - ${K[code]!['nama']}');}
      else{for(var c in m) stdout.writeln('- $c: ${K[c]!['nama']} (Rp${fmt(K[c]!['h'] as int)}) [s:${K[c]!['s']}]');
        var ch=r('Masukkan kode dari list: ').trim().toUpperCase(); if(!K.containsKey(ch)){stdout.writeln('Kode tidak valid'); continue;} code=ch;}
    } else {
      var maybe=raw.toUpperCase();
      if(K.containsKey(maybe)) code=maybe; else {var m=search(K,raw); if(m.isEmpty){stdout.writeln('Tidak dikenali. ketik daftar atau cari.');continue;} if(m.length==1) code=m.first; else{for(var c in m) stdout.writeln('- $c: ${K[c]!['nama']}'); var ch=r('Pilih kode: ').trim().toUpperCase(); if(!K.containsKey(ch)){stdout.writeln('Kode tidak valid');continue;} code=ch;}}
    }
    var q=ri('Jumlah untuk $code: '); if(q<=0){stdout.writeln('Jumlah harus >0');continue;} cart.update(code,(p)=>p+q,ifAbsent:()=>q); stdout.writeln('Ditambahkan $code x $q');
  }
  var subtotal=0.0, snack=0.0; var lines=<Map>[]; var rej=<String>[];
  cart.forEach((c, qty) {
    // existence check
    if (!K.containsKey(c)) {
      rej.add('$c: tidak ada');
    } else {
      var it = K[c]!;
      var s = it['s'] as int;
      var h = it['h'] as int;
      var kat = it['kat'] as String;
      // nested-if: cek stok > 0 dulu
      if (s <= 0) {
        rej.add('$c (${it['nama']}) stok habis');
      } else {
        // stok tersedia, sekarang cek apakah qty diminta <= stok
        if (qty > s) {
          rej.add('$c (${it['nama']}) stok tidak cukup (minta $qty, stok $s)');
        } else {
          // semua valid — hitung charged (promo minuman) dan subtotal
          var charged = qty;
          if (kat == 'minuman' && qty >= 6) {
            charged = qty - (qty ~/ 6);
          }
          var lsubtotal = charged * h.toDouble();
          if (kat == 'snack') snack += lsubtotal;
          subtotal += lsubtotal;
          var free = qty - charged;
          lines.add({'c': c, 'nama': it['nama'], 'qty': qty, 'chg': charged, 'free': free, 'h': h, 'sub': lsubtotal});
        }
      }
    }
  });
  var discSnack= snack>50000? snack*0.1:0.0; var after=subtotal-discSnack; var discMember=0.0; var voucher=0.0; if(after>150000){ if(member) discMember=after*0.05; else if(after>200000) voucher=10000; } var total= after-discMember;
  for(var L in lines){ var code=L['c'] as String; K[code]!['s']= (K[code]!['s'] as int) - (L['qty'] as int); }
  stdout.writeln('\n--- Struk ---'); stdout.writeln('Kode Nama               qty/chg harga   subtotal');
  for(var L in lines){
    stdout.writeln('${L['c']} ${(L['nama'] as String).padRight(18)} ${(L['qty'].toString()).padLeft(3)}/${(L['chg'].toString()).padLeft(3)} Rp${fmt(L['h'] as int)} Rp${fmt((L['sub'] as double).round())}');
    var free = (L['free'] ?? 0) as int;
    if(free>0) stdout.writeln('   promo: beli 5 gratis 1 (gratis ${free})');
  }
  if(rej.isNotEmpty){stdout.writeln('\nItem ditolak:'); rej.forEach((r)=>stdout.writeln('- $r'));}
  stdout.writeln('\nSubtotal    : Rp${fmt(subtotal.round())}'); if(discSnack>0) stdout.writeln('Diskon snack: Rp${fmt(discSnack.round())}'); if(discMember>0) stdout.writeln('Diskon member: Rp${fmt(discMember.round())}'); if(voucher>0) stdout.writeln('Voucher: Rp${fmt(voucher.round())}'); stdout.writeln('Total bayar : Rp${fmt(total.round())}');
  stdout.writeln('\nSisa stok:'); for(var L in lines) stdout.writeln('- ${L['c']} ${K[L['c']!]!['nama']} : ${K[L['c']!]!['s']}'); stdout.writeln('\n--- Terima kasih ---');
}
String r([String p='']){stdout.write(p); return stdin.readLineSync()??'';}
int ri([String p='']){while(true){var s=r(p); var v=int.tryParse(s); if(v!=null) return v; stdout.writeln('Masukkan angka bulat');}}
bool yn([String p='']){while(true){var s=r(p).trim().toLowerCase(); if(['y','ya','yes'].contains(s)) return true; if(['n','no','tidak'].contains(s)) return false; stdout.writeln('jawab y/n');}}
String fmt(int v){var s=v.toString(); var b=StringBuffer(); for(var i=s.length-1,j=1;i>=0;i--,j++){b.write(s[i]); if(j%3==0 && i!=0) b.write('.');} return b.toString().split('').reversed.join();}
void printK(Map K){stdout.writeln('\nDaftar:'); K.forEach((c,i)=>stdout.writeln('- $c : ${i['nama']} (${i['kat']}) Rp${fmt(i['h'] as int)} [s:${i['s']}]'));}
List<String> search(Map K,String t){t=t.trim().toLowerCase(); if(t.isEmpty) return <String>[]; return K.entries.where((e)=> (e.value['nama'] as String).toLowerCase().contains(t)).map((e)=>e.key as String).toList(growable:false);}
