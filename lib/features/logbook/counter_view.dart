import 'package:flutter/material.dart';
import 'counter_controller.dart';
import '../onboarding/onboarding_view.dart';

class CounterView extends StatefulWidget {
  final String username;

  const CounterView({super.key, required this.username});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    await _controller.init();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${widget.username}"),
        backgroundColor: const Color(0xFF194569),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF194569), Color(0xFF5F84A2)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "LogBook: SRP Version",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // Card Total Hitungan
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "TOTAL HITUNGAN",
                        style: TextStyle(letterSpacing: 2, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${_controller.value}',
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF194569),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Step Slider
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Step: ${_controller.step}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Slider(
                        value: _controller.step.toDouble(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        activeColor: const Color(0xFF194569),
                        onChanged: (value) {
                          setState(() {
                            _controller.setStep(value.toInt());
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Tombol Kurang, Reset, Tambah
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(
                      icon: Icons.remove,
                      bgColor: const Color(0xFFF8BBD0),
                      iconColor: Colors.red.shade700,
                      onPressed: () => setState(() => _controller.decrement()),
                    ),
                    _buildButton(
                      icon: Icons.refresh,
                      bgColor: const Color(0xFFBBDEFB),
                      iconColor: Colors.blue.shade700,
                      onPressed: () => _showResetDialog(),
                    ),
                    _buildButton(
                      icon: Icons.add,
                      bgColor: const Color(0xFFC8E6C9),
                      iconColor: Colors.green.shade700,
                      onPressed: () => setState(() => _controller.increment()),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Riwayat aktivitas
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _controller.history.isEmpty
                        ? const Center(
                            child: Text(
                              "Belum ada aktivitas",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.separated(
                            itemCount: _controller.history.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 20),
                            itemBuilder: (context, index) {
                              final item = _controller.history[index];

                              IconData icon;
                              Color iconColor;

                              if (item.contains("Menambah")) {
                                icon = Icons.add;
                                iconColor = Colors.green;
                              } else if (item.contains("Mengurangi")) {
                                icon = Icons.remove;
                                iconColor = Colors.red;
                              } else {
                                icon = Icons.refresh;
                                iconColor = Colors.blue;
                              }

                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: iconColor.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(icon, color: iconColor, size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: iconColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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

  Widget _buildButton({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        backgroundColor: bgColor,
        elevation: 2,
      ),
      onPressed: onPressed,
      child: Icon(icon, size: 28, color: iconColor),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Reset"),
        content: const Text(
          "Apakah kamu yakin ingin mereset?\nData riwayat tidak bisa dikembalikan.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _controller.reset();
              });

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    "Reset berhasil!",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah kamu yakin ingin logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const OnboardingView()),
                (route) => false,
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
