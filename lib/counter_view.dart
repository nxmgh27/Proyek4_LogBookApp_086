import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    fontSize: 24,
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
                      onPressed: () => setState(() => _controller.reset()),
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
                SizedBox(
                  height: 250,
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
                                icon = Icons.arrow_upward;
                                iconColor = Colors.green;
                              } else if (item.contains("Mengurangi")) {
                                icon = Icons.arrow_downward;
                                iconColor = Colors.red;
                              } else {
                                icon = Icons.refresh;
                                iconColor = Colors.blue;
                              }

                              final parts = item.split(" pada ");
                              final action = parts[0];
                              final time = parts.length > 1 ? parts[1] : "";

                              return Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: iconColor.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      icon,
                                      color: iconColor,
                                      size: 20,
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Text(
                                      action,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                  Text(
                                    time,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
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
}
