import 'package:flutter/material.dart';

class HasilPage extends StatelessWidget {
  const HasilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data argumen dari FormPage
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String nama = data?['nama'] ?? '';
    final String nis = data?['nis'] ?? '';
    final String kelas = data?['kelas'] ?? '';
    final String noHp = data?['noHp'] ?? '';
    final String gender = data?['gender'] ?? '';
    final String ekskulString = data?['ekskul'] ?? '';

    final List<String> listEkskul = ekskulString.isNotEmpty
        ? ekskulString.split(',').map((e) => e.trim()).toList()
        : [];

    final bool isDataEmpty = data == null || nama.isEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Hasil Pendaftaran Ekskul',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: isDataEmpty
                ? _buildEmptyState(context)
                : _buildHasilCard(
                    context,
                    nama: nama,
                    nis: nis,
                    kelas: kelas,
                    noHp: noHp,
                    gender: gender,
                    ekskul: listEkskul,
                  ),
          ),
        ),
      ),
    );
  }

  // Tampilan jika belum ada data pendaftaran
  Widget _buildEmptyState(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Icon(Icons.info_outline, size: 70, color: Colors.indigo),
            const SizedBox(height: 16),
            const Text(
              'Belum Ada Data Pendaftaran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 8),
            const Text(
              'Silakan isi formulir pendaftaran terlebih dahulu untuk melihat hasil data Anda.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, '/form'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.assignment),
                label: const Text('Buka Form Pendaftaran', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tampilan kartu bukti hasil pendaftaran
  Widget _buildHasilCard(
    BuildContext context, {
    required String nama,
    required String nis,
    required String kelas,
    required String noHp,
    required String gender,
    required List<String> ekskul,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pendaftaran Telah Berhasil',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 18),

            // Baris Data
            _buildHasilRow(Icons.person, 'Nama Lengkap', nama, Colors.indigo),
            const SizedBox(height: 12),
            _buildHasilRow(Icons.badge, 'NIS (Nomor Induk Siswa)', nis, Colors.indigo),
            const SizedBox(height: 12),
            _buildHasilRow(Icons.school, 'Kelas', kelas, Colors.indigo),
            const SizedBox(height: 12),
            _buildHasilRow(Icons.phone, 'Nomor HP', noHp, Colors.indigo),
            const SizedBox(height: 12),
            _buildHasilRow(
              gender == 'Laki-laki' ? Icons.male : Icons.female,
              'Jenis Kelamin',
              gender,
              gender == 'Laki-laki' ? Colors.blue : Colors.pink,
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 16),

            // Pilihan Ekskul
            const Text(
              'Ekstrakurikuler yang Dipilih:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: ekskul.map((item) {
                final color = _getEkskulColor(item);
                final icon = _getEkskulIcon(item);

                return Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.white, child: Icon(icon, color: color, size: 16)),
                  label: Text(item, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  backgroundColor: color,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Tombol Navigasi
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.indigo,
                      side: const BorderSide(color: Colors.indigo),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Ke Form'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.home),
                    label: const Text('Ke Home'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHasilRow(IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: color.withOpacity(0.12),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  Color _getEkskulColor(String ekskul) {
    switch (ekskul.toLowerCase()) {
      case 'basket': return Colors.orange;
      case 'futsal': return Colors.green;
      case 'pramuka': return Colors.brown;
      case 'taekwondo': return Colors.red;
      case 'silat': return Colors.blue;
      default: return Colors.indigo;
    }
  }

  IconData _getEkskulIcon(String ekskul) {
    switch (ekskul.toLowerCase()) {
      case 'basket': return Icons.sports_basketball;
      case 'futsal': return Icons.sports_soccer;
      case 'pramuka': return Icons.campaign;
      case 'taekwondo':
      case 'silat': return Icons.sports_martial_arts;
      default: return Icons.sports;
    }
  }
}