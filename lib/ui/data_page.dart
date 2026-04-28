import 'package:flutter/material.dart';
import '../models/laundry_order.dart';
import 'data_detail.dart';
import 'data_form.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  // Fungsi untuk refresh UI saat kembali ke halaman ini
  void refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil data dari Database Dummy Global
    final daftarLaundry = LaundryDB.data.reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Laundry'), backgroundColor: Colors.blue[800]),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: daftarLaundry.length,
        itemBuilder: (context, index) {
          final order = daftarLaundry[index];
          // Memanggil ItemLaundryCard dan mengirimkan fungsi refreshList
          return ItemLaundryCard(order: order, onUpdate: refreshList);
        },
      ),
      // Tombol melayang untuk navigasi ke Form (Syarat Navigasi)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DataForm(
                onSaveSuccess: () {
                  Navigator.pop(context); // Kembali ke daftar jika berhasil
                },
              ),
            ),
          ).then((_) => refreshList()); // Refresh daftar setelah form ditutup
        },
      ),
    );
  }
} // <--- Pastikan penutup class _DataPageState ada di sini

// Class StatelessWidget dipisah di luar (di bawah) _DataPageState
class ItemLaundryCard extends StatelessWidget {
  final LaundryOrder order;
  final VoidCallback onUpdate;

  const ItemLaundryCard({Key? key, required this.order, required this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.orange;
    if (order.status == 'Selesai') statusColor = Colors.green;
    if (order.status == 'Batal') statusColor = Colors.red;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.2),
          child: Icon(Icons.local_laundry_service, color: statusColor),
        ),
        title: Text(order.namaPelanggan, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${order.jenisLayanan} - ${order.berat} Kg\nStatus: ${order.status}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navigasi ke detail
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DataDetail(order: order)),
          ).then((_) => onUpdate()); // Refresh list ketika kembali dari detail
        },
      ),
    );
  }
}