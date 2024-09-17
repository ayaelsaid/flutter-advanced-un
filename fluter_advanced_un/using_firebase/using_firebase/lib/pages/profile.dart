import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final ValueChanged<Color> onColorChanged; // Callback to notify color change

  const SettingsPage({Key? key, required this.onColorChanged}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color _selectedColor = Colors.white; // Default color

  @override
  void initState() {
    super.initState();
    _loadColorPreference();
  }

  Future<void> _loadColorPreference() async {
    final prefs = await SharedPreferences.getInstance();
    int colorValue = prefs.getInt('themeColor') ?? Colors.white.value;
    setState(() {
      _selectedColor = Color(colorValue);
    });
  }

  Future<void> _saveColorPreference(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeColor', color.value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Theme Color',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _colorOption(Colors.white, 'White'),
              _colorOption(Colors.blue, 'Blue'),
              _colorOption(Colors.green, 'Green'),
              _colorOption(Colors.red, 'Red'),
              _colorOption(Colors.yellow, 'Yellow'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _colorOption(Color color, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
        _saveColorPreference(color);
        widget.onColorChanged(color); // Notify the parent about the color change
      },
      child: Container(
        width: 50,
        height: 50,
        color: color,
        child: _selectedColor == color
            ? const Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }
}
