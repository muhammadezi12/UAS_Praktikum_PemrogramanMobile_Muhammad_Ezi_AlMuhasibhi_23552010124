import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/todo_controller.dart';
import '../models/pengajuan_seminar.dart';

class AddTodoPage extends StatefulWidget {
  final PengajuanSeminar? pengajuan;
  final int? index;

  const AddTodoPage({
    super.key,
    this.pengajuan,
    this.index,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  @override
void initState() {
  super.initState();

  if (widget.pengajuan != null) {
    _namaCtrl.text = widget.pengajuan!.nama;
    _nimCtrl.text = widget.pengajuan!.nim;
    _judulCtrl.text = widget.pengajuan!.judul;
    _dosenCtrl.text = widget.pengajuan!.dosenPembimbing;
    _ruanganCtrl.text = widget.pengajuan!.ruangan;
    _tanggalSeminar = widget.pengajuan!.tanggalSeminar;
    _berkasLengkap = widget.pengajuan!.berkasLengkap;
  }
}
  final _formKey = GlobalKey<FormState>();

  final _namaCtrl = TextEditingController();
  final _nimCtrl = TextEditingController();
  final _judulCtrl = TextEditingController();
  final _dosenCtrl = TextEditingController();
  final _ruanganCtrl = TextEditingController();

  DateTime? _tanggalSeminar;
  bool _berkasLengkap = false;

  @override
  void dispose() {
    _namaCtrl.dispose();
    _nimCtrl.dispose();
    _judulCtrl.dispose();
    _dosenCtrl.dispose();
    _ruanganCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickTanggal() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 3),
    );

    if (picked != null) {
      setState(() {
        _tanggalSeminar = picked;
      });
    }
  }

  void _simpanPengajuan() {
    if (!_formKey.currentState!.validate()) return;

    if (_tanggalSeminar == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tanggal seminar wajib dipilih'),
        ),
      );
      return;
    }

    final pengajuan = PengajuanSeminar(
      nama: _namaCtrl.text.trim(),
      nim: _nimCtrl.text.trim(),
      judul: _judulCtrl.text.trim(),
      dosenPembimbing: _dosenCtrl.text.trim(),
      tanggalSeminar: _tanggalSeminar!,
      ruangan: _ruanganCtrl.text.trim(),
      berkasLengkap: _berkasLengkap,
    );

    final controller = context.read<TodoController>();

if (widget.pengajuan == null) {
  controller.addPengajuan(pengajuan);
} else {
  controller.updatePengajuan(
    widget.index!,
    pengajuan,
  );
}

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Berhasil"),
        content: const Text(
          "Pengajuan seminar berhasil disimpan.",
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label wajib diisi";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      appBar: AppBar(
  title: Text(
    widget.pengajuan == null
        ? "Tambah Pengajuan"
        : "Edit Pengajuan",
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff6C63FF),
                Color(0xff8E2DE2),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xffEEE9FF),
                      child: Icon(
                        Icons.school,
                        color: Color(0xff6C63FF),
                        size: 35,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Data Pengajuan Seminar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 25),

                    buildTextField(
                      controller: _namaCtrl,
                      label: "Nama Mahasiswa",
                      icon: Icons.person,
                    ),

                    buildTextField(
                      controller: _nimCtrl,
                      label: "NIM",
                      icon: Icons.badge,
                    ),

                    buildTextField(
                      controller: _judulCtrl,
                      label: "Judul Tugas Akhir",
                      icon: Icons.assignment,
                    ),

                    buildTextField(
                      controller: _dosenCtrl,
                      label: "Dosen Pembimbing",
                      icon: Icons.school,
                    ),

                    buildTextField(
                      controller: _ruanganCtrl,
                      label: "Ruangan Seminar",
                      icon: Icons.meeting_room,
                    ),

                    const SizedBox(height: 10),

                    InkWell(
                      onTap: _pickTanggal,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color(0xff6C63FF),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _tanggalSeminar == null
                                  ? "Pilih Tanggal Seminar"
                                  : _tanggalSeminar!
                                      .toString()
                                      .split(' ')[0],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SwitchListTile(
                      value: _berkasLengkap,
                      activeColor: const Color(0xff6C63FF),
                      title: const Text(
                        "Berkas Lengkap",
                      ),
                      subtitle: Text(
                        _berkasLengkap
                            ? "Semua dokumen telah lengkap"
                            : "Dokumen belum lengkap",
                      ),
                      secondary: Icon(
                        _berkasLengkap
                            ? Icons.check_circle
                            : Icons.pending_actions,
                        color: _berkasLengkap
                            ? Colors.green
                            : Colors.orange,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _berkasLengkap = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: _simpanPengajuan,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    "Simpan Pengajuan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}