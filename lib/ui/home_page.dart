import 'package:flutter/material.dart';
import '../models/laundry_order.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalPesanan = LaundryDB.data.length;
    int pesananSelesai = LaundryDB.data.where((e) => e.status == 'Selesai').length;

    return Scaffold(
      appBar: AppBar(title: const Text('Beranda Laundry'), backgroundColor: Colors.blue[800]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_laundry_service, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text('Selamat Datang di Atha Laundry!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text('Total Pesanan: $totalPesanan', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('Pesanan Selesai: $pesananSelesai', style: const TextStyle(fontSize: 18, color: Colors.green)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}