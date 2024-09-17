import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showEditContent = false;
  bool showSettingsContent = false;
  bool showAchievementsContent = false;
  bool showAboutUsContent = false;

  Color themeColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _loadThemeColor();
  }

  Future<void> _loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    int colorValue = prefs.getInt('themeColor') ?? Colors.white.value;
    setState(() {
      themeColor = Color(colorValue);
    });
  }

  Future<void> _updateProfile() async {
    User? currentUser = _auth.currentUser;
    String newName = _nameController.text.trim();
    String newEmail = _emailController.text.trim();
    String newPassword = _passwordController.text.trim();

    try {
      if (newName.isNotEmpty) {
        await currentUser?.updateDisplayName(newName);
      }

      if (newEmail.isNotEmpty && newEmail != currentUser?.email) {
        await currentUser?.updateEmail(newEmail);
      }

      if (newPassword.isNotEmpty) {
        await currentUser?.updatePassword(newPassword);
      }

      await currentUser?.reload();
      setState(() {
        _auth.currentUser;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Widget profileCards(BuildContext context, String title, IconData icon,
      bool isExpanded, VoidCallback onTap) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
        onTap: onTap,
      ),
    );
  }

  Widget editContent() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _updateProfile,
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget achievementsContent() {
    return const Text('Achievements content goes here...');
  }

  Widget aboutUsContent() {
    return const Text('About Us content goes here...');
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: currentUser?.photoURL != null
                  ? NetworkImage(currentUser!.photoURL!)
                  : const AssetImage('assets/default_profile.png')
                      as ImageProvider,
            ),
            const SizedBox(height: 20),
            Text(
              currentUser?.displayName ?? 'No name provided',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Text(
              currentUser?.email ?? 'No email provided',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),

            profileCards(
              context,
              'Edit',
              Icons.edit,
              showEditContent,
              () {
                setState(() {
                  showEditContent = !showEditContent;
                });
              },
            ),
            if (showEditContent) editContent(),

            profileCards(
              context,
              'Settings',
              Icons.settings,
              showSettingsContent,
              () {
                setState(() {
                  showSettingsContent = !showSettingsContent;
                });
              },
            ),
            if (showSettingsContent)
              SettingsPage(
                onColorChanged: (color) {
                  setState(() {
                    themeColor = color;
                  });
                },
              ),

            profileCards(
              context,
              'Achievements',
              Icons.star,
              showAchievementsContent,
              () {
                setState(() {
                  showAchievementsContent = !showAchievementsContent;
                });
              },
            ),
            if (showAchievementsContent) achievementsContent(),

            profileCards(
              context,
              'About Us',
              Icons.info,
              showAboutUsContent,
              () {
                setState(() {
                  showAboutUsContent = !showAboutUsContent;
                });
              },
            ),
            if (showAboutUsContent) aboutUsContent(),

            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.of(context).pop(); // Go back to the previous screen
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

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
