class LaundryOrder {
  final String kodePesanan;
  final String namaPelanggan;
  final String jenisLayanan;
  final double berat;
  final double totalBiaya;
  String status; // 'Proses', 'Selesai', atau 'Batal'

  LaundryOrder({
    required this.kodePesanan,
    required this.namaPelanggan,
    required this.jenisLayanan,
    required this.berat,
    required this.totalBiaya,
    this.status = 'Proses', // Default status saat pesanan dibuat
  });
}

// Simulasi Database Global agar data bisa disimpan dan dibaca dari halaman manapun
class LaundryDB {
  static List<LaundryOrder> data = [
    LaundryOrder(kodePesanan: 'LD-001', namaPelanggan: 'Andi', jenisLayanan: 'Cuci Setrika', berat: 2.5, totalBiaya: 15000.0, status: 'Selesai'),
    LaundryOrder(kodePesanan: 'LD-002', namaPelanggan: 'Budi', jenisLayanan: 'Cuci Kering', berat: 3.0, totalBiaya: 12000.0, status: 'Proses'),
    LaundryOrder(kodePesanan: 'LD-003', namaPelanggan: 'Citra', jenisLayanan: 'Setrika Saja', berat: 1.5, totalBiaya: 6000.0, status: 'Batal'),
    LaundryOrder(kodePesanan: 'LD-004', namaPelanggan: 'Dewi', jenisLayanan: 'Cuci Bedcover', berat: 4.0, totalBiaya: 30000.0, status: 'Proses'),
    LaundryOrder(kodePesanan: 'LD-005', namaPelanggan: 'Eko', jenisLayanan: 'Cuci Sepatu', berat: 1.0, totalBiaya: 25000.0, status: 'Proses'),
  ];
}