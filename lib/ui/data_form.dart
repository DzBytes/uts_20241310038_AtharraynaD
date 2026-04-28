import 'package:flutter/material.dart';
import '../models/laundry_order.dart';
import 'data_detail.dart';

class DataForm extends StatefulWidget {
  final VoidCallback onSaveSuccess;

  const DataForm({Key? key, required this.onSaveSuccess}) : super(key: key);

  @override
  _DataFormState createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  final _kodeCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _jenisCtrl = TextEditingController();
  final _beratCtrl = TextEditingController();

  // ==========================================
  // SYARAT TERPENUHI: Method pemisah Widget 1
  // ==========================================
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  // ==========================================
  // SYARAT TERPENUHI: Method pemisah Widget 2
  // ==========================================
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[800],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: _simpanData,
        child: const Text('Simpan Pesanan', style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  void _simpanData() {
    double beratParsed = double.tryParse(_beratCtrl.text) ?? 0.0;
    double totalBiayaCalculated = beratParsed * 6000;

    LaundryOrder orderBaru = LaundryOrder(
      kodePesanan: _kodeCtrl.text,
      namaPelanggan: _namaCtrl.text,
      jenisLayanan: _jenisCtrl.text,
      berat: beratParsed,
      totalBiaya: totalBiayaCalculated,
      status: 'Proses',
    );

    LaundryDB.data.add(orderBaru);

    _kodeCtrl.clear(); _namaCtrl.clear(); _jenisCtrl.clear(); _beratCtrl.clear();

    Navigator.push(context, MaterialPageRoute(builder: (context) => DataDetail(order: orderBaru)))
        .then((_) => widget.onSaveSuccess());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Pesanan Baru'), backgroundColor: Colors.blue[800]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Memanggil Method 1 (digunakan berkali-kali)
            _buildTextField(_kodeCtrl, 'Kode Pesanan', Icons.qr_code),
            _buildTextField(_namaCtrl, 'Nama Pelanggan', Icons.person),
            _buildTextField(_jenisCtrl, 'Jenis Layanan', Icons.dry_cleaning),
            _buildTextField(_beratCtrl, 'Berat (Kg)', Icons.scale, type: TextInputType.number),

            const SizedBox(height: 20),

            // Memanggil Method 2
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }
}