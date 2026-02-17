import 'package:shared_preferences/shared_preferences.dart';

class CounterController {
  int _value = 0;
  int _step = 1;

  // History list
  final List<String> _history = [];

  int get value => _value;
  int get step => _step;
  List<String> get history => _history;

  // SharedPreferences keys
  static const String _keyValue = 'counter_value';
  static const String _keyStep = 'counter_step';
  static const String _keyHistory = 'counter_history';

  CounterController();

  Future<void> init() async {
    await _loadFromPrefs();
  }

  void increment() {
    _value += _step;
    _addHistory("Menambah +$_step");
    _saveToPrefs();
  }

  void decrement() {
    _value -= _step;
    _addHistory("Mengurangi -$_step");
    _saveToPrefs();
  }

  void reset() {
    _value = 0;
    _addHistory("Reset ke 0");
    _saveToPrefs();
  }

  void setStep(int newStep) {
    _step = newStep;
    _saveToPrefs();
  }

  void _addHistory(String action) {
    final now = DateTime.now();
    final time =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    final entry = " $action pada jam $time";
    _history.insert(0, entry);

    // Misal maksimal 20 history
    if (_history.length > 20) {
      _history.removeLast();
    }

    _saveHistoryToPrefs();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyValue, _value);
    await prefs.setInt(_keyStep, _step);
    await _saveHistoryToPrefs();
  }

  Future<void> _saveHistoryToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyHistory, _history);
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _value = prefs.getInt(_keyValue) ?? 0;
    _step = prefs.getInt(_keyStep) ?? 1;
    _history.clear();
    _history.addAll(prefs.getStringList(_keyHistory) ?? []);
  }
}
