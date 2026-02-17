class CounterController {
  int _value = 0;
  int _step = 1;

  // History list
  final List<String> _history = [];

  int get value => _value;
  int get step => _step;
  List<String> get history => _history;

  void increment() {
    _value += _step;
    _addHistory("Menambah $_step");
  }

  void decrement() {
    _value -= _step;
    _addHistory("Mengurangi $_step");
  }

  void reset() {
    _value = 0;
    _addHistory("Reset ke 0");
  }

  void setStep(int newStep) {
    _step = newStep;
  }

  // Batasi hanya 5 riwayat terakhir
  void _addHistory(String action) {
    final now = DateTime.now();
    final time =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    _history.insert(0, "$action pada $time");

    if (_history.length > 5) {
      _history.removeLast();
    }
  }
}
