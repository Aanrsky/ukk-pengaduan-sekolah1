import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firestore_service.dart';

class PengaduanPage extends StatefulWidget {
  const PengaduanPage({super.key});

  @override
  State<PengaduanPage> createState() => _PengaduanPageState();
}

class _PengaduanPageState extends State<PengaduanPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();
  final ImagePicker picker = ImagePicker();

  String kategori = 'Sarana Rusak';

  bool loading = false;
  String loadingText = 'MENGIRIM...';

  Uint8List? selectedImage;

  @override
  void dispose() {
    namaController.dispose();
    judulController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  Future<void> pilihFoto() async {
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 55,
        maxWidth: 960,
        maxHeight: 960,
      );

      if (image == null) {
        return;
      }

      final bytes = await image.readAsBytes();

      if (!mounted) {
        return;
      }

      setState(() {
        selectedImage = bytes;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Foto berhasil dipilih'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memilih foto: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<String> uploadFoto() async {
    if (selectedImage == null) {
      return '';
    }

    final fileName = 'pengaduan_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final ref =
        FirebaseStorage.instance.ref().child('foto_pengaduan').child(fileName);

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      cacheControl: 'public,max-age=31536000',
    );

    try {
      final uploadTask = ref.putData(
        selectedImage!,
        metadata,
      );

      final snapshot = await uploadTask;

      if (snapshot.state != TaskState.success) {
        throw Exception(
          'Upload foto gagal: ${snapshot.state}',
        );
      }

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint('Upload foto error: $e');
      rethrow;
    }
  }

  Future<void> kirimPengaduan() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      loading = true;

      if (selectedImage != null) {
        loadingText = 'MENGUPLOAD FOTO...';
      } else {
        loadingText = 'MENYIMPAN...';
      }
    });

    try {
      String fotoUrl = '';

      if (selectedImage != null) {
        fotoUrl = await uploadFoto();

        if (!mounted) {
          return;
        }

        setState(() {
          loadingText = 'MENYIMPAN PENGADUAN...';
        });
      }

      await firestoreService.addComplaint(
        nama: namaController.text.trim(),
        kategori: kategori,
        judul: judulController.text.trim(),
        deskripsi: deskripsiController.text.trim(),
        fotoUrl: fotoUrl,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pengaduan berhasil dikirim',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      debugPrint('Gagal mengirim pengaduan: $e');

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal mengirim pengaduan: $e',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
          loadingText = 'MENGIRIM...';
        });
      }
    }
  }

  InputDecoration inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: const Color(0xff1d149f),
      ),
      filled: true,
      fillColor: const Color(0xFFF7F9FC),
      labelStyle: const TextStyle(
        color: Color(0xFF627D98),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFE3EAF2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFF1976D2),
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1976D2);
    const textColor = Color(0xFF102A43);
    const secondaryColor = Color(0xFF627D98);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: const Text(
          'Buat Pengaduan',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: textColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            18,
            18,
            18,
            30,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // HEADER
                // =========================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFE3EAF2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.04,
                        ),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F1FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.campaign_outlined,
                          color: primaryColor,
                          size: 38,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Sampaikan Pengaduan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Laporkan kerusakan atau masalah '
                        'sarana sekolah dengan mudah.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // =========================
                // DATA PENGADU
                // =========================
                const Text(
                  'Data Pengadu',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE3EAF2),
                    ),
                  ),
                  child: Column(
                    children: [
                      // NAMA
                      TextFormField(
                        controller: namaController,
                        enabled: !loading,
                        decoration: inputDecoration(
                          label: 'Nama',
                          icon: Icons.person_outline,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama wajib diisi';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // KATEGORI
                      DropdownButtonFormField<String>(
                        initialValue: kategori,
                        decoration: inputDecoration(
                          label: 'Kategori Pengaduan',
                          icon: Icons.category_outlined,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Sarana Rusak',
                            child: Text('Sarana Rusak'),
                          ),
                          DropdownMenuItem(
                            value: 'Kebersihan',
                            child: Text('Kebersihan'),
                          ),
                          DropdownMenuItem(
                            value: 'Keamanan',
                            child: Text('Keamanan'),
                          ),
                          DropdownMenuItem(
                            value: 'Lainnya',
                            child: Text('Lainnya'),
                          ),
                        ],
                        onChanged: loading
                            ? null
                            : (value) {
                                if (value == null) {
                                  return;
                                }

                                setState(() {
                                  kategori = value;
                                });
                              },
                      ),

                      const SizedBox(height: 15),

                      // JUDUL
                      TextFormField(
                        controller: judulController,
                        enabled: !loading,
                        decoration: inputDecoration(
                          label: 'Judul Pengaduan',
                          icon: Icons.title_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Judul wajib diisi';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // DESKRIPSI
                      TextFormField(
                        controller: deskripsiController,
                        enabled: !loading,
                        maxLines: 5,
                        decoration: inputDecoration(
                          label: 'Deskripsi Pengaduan',
                          icon: Icons.description_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Deskripsi wajib diisi';
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // =========================
                // FOTO
                // =========================
                const Text(
                  'Foto Kerusakan',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE3EAF2),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (selectedImage == null)
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F9FC),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFD9E2EC),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 48,
                                color: Color(0xFF90A4AE),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Belum ada foto',
                                style: TextStyle(
                                  color: Color(0xFF627D98),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (selectedImage != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(
                            selectedImage!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: loading ? null : pilihFoto,
                          icon: const Icon(
                            Icons.add_a_photo_outlined,
                          ),
                          label: Text(
                            selectedImage == null ? 'PILIH FOTO' : 'GANTI FOTO',
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                            side: const BorderSide(
                              color: primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // =========================
                // TOMBOL KIRIM
                // =========================
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: loading ? null : kirimPengaduan,
                    icon: loading
                        ? const SizedBox(
                            width: 21,
                            height: 21,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.send_rounded,
                          ),
                    label: Text(
                      loading ? loadingText : 'KIRIM PENGADUAN',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: primaryColor.withValues(
                        alpha: 0.55,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                const Center(
                  child: Text(
                    'Pastikan data pengaduan sudah benar sebelum dikirim.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
