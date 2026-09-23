import 'package:flutter/material.dart';

import 'pengaduan_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool darkMode = false;

  final Color blue = const Color(0xFF246BCE);
  final Color darkBlue = const Color(0xFF102F5F);

  @override
  Widget build(BuildContext context) {
    final Color background =
        darkMode ? const Color(0xFF101820) : const Color(0xFFF8FAFD);

    final Color card = darkMode ? const Color(0xFF1B2735) : Colors.white;

    final Color titleColor = darkMode ? Colors.white : darkBlue;

    final Color subColor = darkMode ? Colors.white70 : const Color(0xFF58708D);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ==================================================
              // HEADER
              // ==================================================
              Container(
                margin: const EdgeInsets.fromLTRB(
                  18,
                  16,
                  18,
                  0,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: darkMode ? Colors.white10 : const Color(0xFFE4EBF4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.04,
                      ),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // LOGO PENGGANTI PP
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: darkMode
                            ? const Color(0xFF203B5E)
                            : const Color(0xFFEAF2FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.school_rounded,
                        color: blue,
                        size: 29,
                      ),
                    ),

                    const SizedBox(width: 11),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SMP Negeri 3 Bantul',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Aplikasi Pengaduan Sarana',
                            style: TextStyle(
                              color: subColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),

                    _headerButton(
                      icon: Icons.notifications_none_rounded,
                      color: titleColor,
                      card: card,
                      badge: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Belum ada notifikasi baru',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),

                    const SizedBox(width: 6),

                    _headerButton(
                      icon: Icons.star_border_rounded,
                      color: titleColor,
                      card: card,
                      onTap: () {},
                    ),

                    const SizedBox(width: 6),

                    _headerButton(
                      icon: Icons.help_outline_rounded,
                      color: titleColor,
                      card: card,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Tentang Aplikasi',
                              ),
                              content: const Text(
                                'Aplikasi Pengaduan Sarana '
                                'SMP Negeri 3 Bantul digunakan '
                                'untuk melaporkan masalah '
                                'sarana dan fasilitas sekolah.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('TUTUP'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(width: 6),

                    _headerButton(
                      icon: darkMode
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      color: titleColor,
                      card: card,
                      onTap: () {
                        setState(() {
                          darkMode = !darkMode;
                        });
                      },
                    ),

                    const SizedBox(width: 6),

                    _headerButton(
                      icon: Icons.logout_rounded,
                      color: Colors.redAccent,
                      card: card,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),

              // ==================================================
              // WELCOME
              // ==================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  25,
                  48,
                  25,
                  0,
                ),
                child: Column(
                  children: [
                    // ICON SEKOLAH
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: darkMode
                            ? const Color(0xFF18385F)
                            : const Color(0xFFEAF2FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.school_rounded,
                        size: 58,
                        color: blue,
                      ),
                    ),

                    const SizedBox(height: 27),

                    Text(
                      'SELAMAT DATANG',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.4,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'APLIKASI PENGADUAN SARANA\nSEKOLAH',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: darkMode ? const Color(0xFF72A7F5) : blue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      '“Laporkan masalah fasilitas sekolah dengan\nmudah.”',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: subColor,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: 90,
                      height: 4,
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      'SMP Negeri 3 Bantul',
                      style: TextStyle(
                        color: subColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // MENU UTAMA
              // ==================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  22,
                  45,
                  22,
                  0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'MENU UTAMA',
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ==================================================
              // BUAT PENGADUAN
              // ==================================================
              _menuCard(
                context: context,
                card: card,
                icon: Icons.campaign_rounded,
                iconColor: Colors.white,
                iconBackground: blue,
                title: 'Buat Pengaduan',
                description: 'Laporkan kerusakan\natau masalah sarana sekolah.',
                titleColor: titleColor,
                subColor: subColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PengaduanPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 15),

              // ==================================================
              // RIWAYAT
              // ==================================================
              _menuCard(
                context: context,
                card: card,
                icon: Icons.history_rounded,
                iconColor: blue,
                iconBackground: darkMode
                    ? const Color(0xFF203B5E)
                    : const Color(0xFFEAF2FF),
                title: 'Riwayat Pengaduan',
                description: 'Lihat daftar pengaduan\nAnda yang sudah dikirim.',
                titleColor: titleColor,
                subColor: subColor,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Halaman riwayat akan dibuat',
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              // ==================================================
              // TEMA
              // ==================================================
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: darkMode ? Colors.white10 : const Color(0xFFE4EBF4),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: darkMode
                            ? const Color(0xFF203B5E)
                            : const Color(0xFFEAF2FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        darkMode
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        color: blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tema Aplikasi',
                            style: TextStyle(
                              color: titleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            darkMode ? 'Mode gelap' : 'Mode terang',
                            style: TextStyle(
                              color: subColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: darkMode,
                      activeThumbColor: blue,
                      onChanged: (value) {
                        setState(() {
                          darkMode = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerButton({
    required IconData icon,
    required Color color,
    required Color card,
    required VoidCallback onTap,
    bool badge = false,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(13),
            child: Ink(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: Colors.black.withValues(
                    alpha: 0.07,
                  ),
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: 21,
              ),
            ),
          ),
        ),
        if (badge)
          Positioned(
            right: -3,
            top: -5,
            child: Container(
              width: 17,
              height: 17,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _menuCard({
    required BuildContext context,
    required Color card,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String description,
    required Color titleColor,
    required Color subColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Ink(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.black.withValues(
                  alpha: 0.06,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.04,
                  ),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 31,
                  ),
                ),
                const SizedBox(width: 17),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: TextStyle(
                          color: subColor,
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: iconColor,
                    size: 20,
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
