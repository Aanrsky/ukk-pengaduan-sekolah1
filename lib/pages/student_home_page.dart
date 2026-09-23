import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/notification_service.dart';

import 'history_page.dart';
import 'pengaduan_page.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final NotificationService _notificationService = NotificationService.instance;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      _notificationService.startStudentNotificationListener(user.uid);
    }
  }

  @override
  void dispose() {
    _notificationService.stopStudentNotificationListener();
    super.dispose();
  }

  // =========================
  // WARNA TEMA NAVY
  // =========================
  static const Color navy = Color(0xFF0B1F3A);
  static const Color navyLight = Color(0xFF163A63);
  static const Color blue = Color(0xFF2563EB);
  static const Color background = Color(0xFFF6F8FC);
  static const Color textDark = Color(0xFF172033);
  static const Color textGrey = Color(0xFF718096);

  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? const Color(0xFF101827) : background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGreeting(),
                    const SizedBox(height: 20),
                    _buildMainComplaintCard(),
                    const SizedBox(height: 16),
                    _buildQuickMenu(),
                    const SizedBox(height: 20),
                    _buildTipsCard(),
                    const SizedBox(height: 22),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildTopHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        16,
        18,
      ),
      decoration: const BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
            child: const Icon(
              Icons.school_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SMP Negeri 3 Bantul',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Layanan Pengaduan Sarana',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),

          // =====================================================
          // NOTIFIKASI
          // =====================================================
          StreamBuilder<int>(
            stream: _notificationService.unreadNotificationCount(
              FirebaseAuth.instance.currentUser?.uid ?? '',
            ),
            builder: (context, snapshot) {
              final unreadCount = snapshot.data ?? 0;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: _showNotifications,
                    icon: Icon(
                      unreadCount > 0
                          ? Icons.notifications
                          : Icons.notifications_none,
                      color: Colors.white,
                    ),
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: navy,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          const SizedBox(width: 7),

          _headerIconButton(
            icon:
                darkMode ? Icons.light_mode_rounded : Icons.dark_mode_outlined,
            onTap: _toggleTheme,
          ),

          const SizedBox(width: 7),

          _headerIconButton(
            icon: Icons.more_vert_rounded,
            onTap: _showMoreMenu,
          ),
        ],
      ),
    );
  }

  Widget _headerIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 21,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // GREETING
  // =========================================================

  Widget _buildGreeting() {
    final titleColor = darkMode ? Colors.white : textDark;
    final subtitleColor = darkMode ? Colors.white60 : textGrey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Halo, Siswa 👋',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: titleColor,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Ada fasilitas sekolah yang perlu dilaporkan?',
          style: TextStyle(
            fontSize: 14,
            color: subtitleColor,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // MAIN COMPLAINT CARD
  // =========================================================

  Widget _buildMainComplaintCard() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PengaduanPage(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(23),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                navy,
                navyLight,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: navy.withValues(alpha: 0.22),
                blurRadius: 18,
                offset: const Offset(0, 9),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.campaign_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Mulai',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Text(
                'Buat Pengaduan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Laporkan kerusakan atau masalah\n'
                'sarana sekolah dengan mudah.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 19),
              Container(
                height: 1,
                color: Colors.white.withValues(alpha: 0.12),
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.white70,
                    size: 17,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Tambahkan foto dan detail laporan',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // QUICK MENU
  // =========================================================

  Widget _buildQuickMenu() {
    return Row(
      children: [
        Expanded(
          child: _quickCard(
            icon: Icons.history_rounded,
            title: 'Riwayat',
            subtitle: 'Lihat laporan',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryPage(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: _quickCard(
            icon: Icons.help_outline_rounded,
            title: 'Bantuan',
            subtitle: 'Cara menggunakan',
            onTap: _showHelp,
          ),
        ),
      ],
    );
  }

  Widget _quickCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: darkMode ? const Color(0xff335eb0) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: darkMode
                  ? Colors.white.withValues(alpha: 0.07)
                  : const Color(0xFFE7ECF3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: blue.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: blue,
                  size: 22,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: darkMode ? Colors.white : textDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: darkMode ? Colors.white54 : textGrey,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // TIPS
  // =========================================================

  Widget _buildTipsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: darkMode ? const Color(0xFF182235) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: darkMode
              ? Colors.white.withValues(alpha: 0.07)
              : const Color(0xFFE7ECF3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFFFB020).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.lightbulb_outline_rounded,
              color: Color(0xFFFFA000),
              size: 22,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tips Pengaduan',
                  style: TextStyle(
                    color: darkMode ? Colors.white : textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Berikan informasi yang jelas dan '
                  'tambahkan foto agar laporan lebih mudah dipahami.',
                  style: TextStyle(
                    color: darkMode ? Colors.white60 : textGrey,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FOOTER
  // =========================================================

  Widget _buildFooter() {
    return Center(
      child: Text(
        'Aplikasi Pengaduan Sarana • SMP Negeri 3 Bantul',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: darkMode ? Colors.white38 : Colors.grey.shade500,
          fontSize: 10.5,
        ),
      ),
    );
  }

  // =========================================================
  // THEME
  // =========================================================

  void _toggleTheme() {
    setState(() {
      darkMode = !darkMode;
    });
  }

  // =========================================================
  // NOTIFICATION
  // =========================================================

  void _showNotifications() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.72,
          decoration: BoxDecoration(
            color: darkMode ? const Color(0xFF111827) : Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  12,
                  10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Notifikasi',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: darkMode ? Colors.white : textDark,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await _notificationService.markAllAsRead(user.uid);
                      },
                      child: const Text(
                        'Tandai semua',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<
                    List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                  stream: _notificationService.studentNotifications(user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            'Gagal memuat notifikasi.',
                            style: TextStyle(
                              color: darkMode ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ),
                      );
                    }

                    final notifications = snapshot.data ?? [];

                    if (notifications.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_none,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Belum ada notifikasi baru.',
                              style: TextStyle(
                                color: darkMode
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        4,
                        16,
                        24,
                      ),
                      itemCount: notifications.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final doc = notifications[index];
                        final data = doc.data();

                        final title = data['title']?.toString() ?? 'Notifikasi';

                        final body = data['body']?.toString() ?? '';

                        final status = data['status']?.toString() ?? '';

                        final isRead = data['read'] == true;

                        final createdAt = data['createdAt'] as Timestamp?;

                        final date = createdAt?.toDate();

                        return InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            if (!isRead) {
                              await _notificationService.markAsRead(doc.id);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: darkMode
                                  ? const Color(0xFF1F2937)
                                  : const Color(0xFFF6F8FC),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isRead ? Colors.transparent : blue,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: blue.withValues(
                                      alpha: 0.12,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.notifications_active,
                                    color: blue,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              title,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: isRead
                                                    ? FontWeight.w600
                                                    : FontWeight.bold,
                                                color: darkMode
                                                    ? Colors.white
                                                    : textDark,
                                              ),
                                            ),
                                          ),
                                          if (!isRead)
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                        ],
                                      ),
                                      if (body.isNotEmpty) ...[
                                        const SizedBox(height: 5),
                                        Text(
                                          body,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: darkMode
                                                ? Colors.white70
                                                : textGrey,
                                          ),
                                        ),
                                      ],
                                      if (status.isNotEmpty) ...[
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 9,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: blue.withValues(
                                              alpha: 0.10,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            status,
                                            style: const TextStyle(
                                              color: blue,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                      if (date != null) ...[
                                        const SizedBox(height: 7),
                                        Text(
                                          '${date.day.toString().padLeft(2, '0')}/'
                                          '${date.month.toString().padLeft(2, '0')}/'
                                          '${date.year} '
                                          '${date.hour.toString().padLeft(2, '0')}:'
                                          '${date.minute.toString().padLeft(2, '0')}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: darkMode
                                                ? Colors.white54
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================================================
  // MORE MENU
  // =========================================================

  void _showMoreMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: darkMode ? const Color(0xFF182235) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              12,
              18,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 15),
                _moreMenuItem(
                  icon: Icons.star_outline_rounded,
                  title: 'Beri Penilaian',
                  onTap: () {
                    Navigator.pop(context);
                    _showRating();
                  },
                ),
                _moreMenuItem(
                  icon: Icons.info_outline_rounded,
                  title: 'Tentang Aplikasi',
                  onTap: () {
                    Navigator.pop(context);
                    _showAbout();
                  },
                ),
                _moreMenuItem(
                  icon: Icons.logout_rounded,
                  title: 'Keluar',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                    _showLogout();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _moreMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: (iconColor ?? blue).withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: iconColor ?? blue,
          size: 21,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? (darkMode ? Colors.white : textDark),
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: darkMode ? Colors.white38 : Colors.grey,
      ),
    );
  }

  // =========================================================
  // HELP
  // =========================================================

  void _showHelp() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: darkMode ? const Color(0xFF182235) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Text(
            'Cara Menggunakan',
            style: TextStyle(
              color: darkMode ? Colors.white : textDark,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            '1. Tekan "Buat Pengaduan".\n'
            '2. Isi data pengaduan.\n'
            '3. Tambahkan foto jika diperlukan.\n'
            '4. Kirim pengaduan.\n'
            '5. Cek perkembangan laporan melalui menu "Riwayat".',
            style: TextStyle(
              color: darkMode ? Colors.white70 : textGrey,
              height: 1.6,
              fontSize: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Mengerti',
                style: TextStyle(
                  color: blue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // RATING
  // =========================================================

  void _showRating() {
    int selectedRating = 0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor:
                  darkMode ? const Color(0xFF182235) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              title: Text(
                'Beri Penilaian',
                style: TextStyle(
                  color: darkMode ? Colors.white : textDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bagaimana pengalaman kamu?',
                    style: TextStyle(
                      color: darkMode ? Colors.white60 : textGrey,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) {
                        final starNumber = index + 1;

                        return IconButton(
                          onPressed: () {
                            setDialogState(() {
                              selectedRating = starNumber;
                            });
                          },
                          icon: Icon(
                            starNumber <= selectedRating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: const Color(0xFFFFB020),
                            size: 34,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: selectedRating == 0
                      ? null
                      : () {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(
                            this.context,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Terima kasih atas penilaiannya!',
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: const Text('Kirim'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // =========================================================
  // ABOUT
  // =========================================================

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: darkMode ? const Color(0xff3b63ae) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Text(
            'Tentang Aplikasi',
            style: TextStyle(
              color: darkMode ? Colors.white : textDark,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Aplikasi Pengaduan Sarana Sekolah\n'
            'SMP Negeri 3 Bantul\n\n'
            'Digunakan untuk membantu siswa menyampaikan '
            'pengaduan terkait sarana dan prasarana sekolah.',
            style: TextStyle(
              color: darkMode ? Colors.white70 : textGrey,
              height: 1.5,
              fontSize: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Tutup',
                style: TextStyle(
                  color: blue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  void _showLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: darkMode ? const Color(0xff3e67b4) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Text(
            'Keluar',
            style: TextStyle(
              color: darkMode ? Colors.white : textDark,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Apakah kamu yakin ingin keluar dari aplikasi?',
            style: TextStyle(
              color: darkMode ? Colors.white70 : textGrey,
              fontSize: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}
