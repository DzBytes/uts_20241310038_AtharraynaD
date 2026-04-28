import 'package:flutter/material.dart';
import '../models/laundry_order.dart';

class DataDetail extends StatefulWidget {
  final LaundryOrder order;

  const DataDetail({Key? key, required this.order}) : super(key: key);

  @override
  _DataDetailState createState() => _DataDetailState();
}

class _DataDetailState extends State<DataDetail> {
  // Fungsi UPDATE status
  void _updateStatus(String statusBaru) {
    setState(() {
      widget.order.status = statusBaru;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status pesanan diubah menjadi $statusBaru')),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.orange;
    if (widget.order.status == 'Selesai') statusColor = Colors.green;
    if (widget.order.status == 'Batal') statusColor = Colors.red;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pesanan'), backgroundColor: Colors.blue[800]),
      body: SingleChildScrollView( // Ditambah agar tidak overflow
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(20)),
                    child: Text('Status: ${widget.order.status}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const Divider(thickness: 2, height: 30),

                // SYARAT: Minimal 3 Row (kita pakai 4)
                _buildDetailRow('Kode', widget.order.kodePesanan),
                const SizedBox(height: 10),
                _buildDetailRow('Nama', widget.order.namaPelanggan),
                const SizedBox(height: 10),
                _buildDetailRow('Layanan', widget.order.jenisLayanan),
                const SizedBox(height: 10),
                _buildDetailRow('Berat', '${widget.order.berat} Kg'),

                const Divider(thickness: 2, height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Biaya', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Rp ${widget.order.totalBiaya.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                ),

                const SizedBox(height: 30),
                // Tombol Update Status (Selesai / Batal)
                if (widget.order.status == 'Proses') ...[
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () => _updateStatus('Batal'),
                          child: const Text('Batalkan', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () => _updateStatus('Selesai'),
                          child: const Text('Selesai', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Text(label, style: const TextStyle(color: Colors.grey))),
        const Text(': '),
        Expanded(flex: 3, child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
      ],
    );
  }
}