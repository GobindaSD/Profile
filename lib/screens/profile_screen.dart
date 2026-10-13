
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  static const Color purple = Color(0xFF9C27B0);

  void showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      child: Scaffold(
        backgroundColor:
        isDarkMode ? const Color(0xFF121212) : Colors.white,

        appBar: AppBar(
          backgroundColor:
          isDarkMode ? const Color(0xFF121212) : Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'Logout',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text(
                      'Are you sure you want to logout?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(dialogContext),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          showMessage(
                            'Logout',
                            'Connect your authentication system here.',
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header image and profile photo
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 125,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 57,
                            backgroundImage:
                            AssetImage('assets/images/photo.jpg'),
                          ),
                        ),

                        Positioned(
                          right: 0,
                          bottom: 4,
                          child: Material(
                            color: purple,
                            shape: const CircleBorder(),
                            child: IconButton(
                              tooltip: 'Change profile photo',
                              onPressed: () {
                                showMessage(
                                  'Profile Photo',
                                  'Add image_picker to change your photo.',
                                );
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),

              // User name
              const Text(
                'Gobinda Sutra Dhar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                'gobinda@example.com',
                style: TextStyle(
                  fontSize: 15,
                  color: isDarkMode ? Colors.white60 : Colors.grey,
                ),
              ),

              const SizedBox(height: 22),

              // Profile menu
              ProfileMenuItem(
                icon: Icons.person_outline,
                title: 'Personal Information',
                onTap: () {
                  showMessage(
                    'Personal Information',
                    'Add your name, phone number and other details here.',
                  );
                },
              ),

              ProfileMenuItem(
                icon: Icons.lock_outline,
                title: 'Security & Password',
                onTap: () {
                  showMessage(
                    'Security & Password',
                    'Add your password and security settings here.',
                  );
                },
              ),

              ProfileMenuItem(
                icon: Icons.language,
                title: 'Language',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (sheetContext) => SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Select Language',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: const Text('English'),
                            trailing: selectedLanguage == 'English'
                                ? const Icon(Icons.check, color: purple)
                                : null,
                            onTap: () {
                              setState(() {
                                selectedLanguage = 'English';
                              });
                              Navigator.pop(sheetContext);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: const Text('বাংলা'),
                            trailing: selectedLanguage == 'বাংলা'
                                ? const Icon(Icons.check, color: purple)
                                : null,
                            onTap: () {
                              setState(() {
                                selectedLanguage = 'বাংলা';
                              });
                              Navigator.pop(sheetContext);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              ProfileMenuItem(
                icon: isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                title: 'Dark Mode',
                onTap: () {
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                },
                trailing: Switch(
                  value: isDarkMode,
                  activeThumbColor: purple,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
              ),

              ProfileMenuItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  showMessage(
                    'Help & Support',
                    'Add your support email or contact details here.',
                  );
                },
              ),

              ProfileMenuItem(
                icon: Icons.info_outline,
                title: 'Privacy Policy',
                onTap: () {
                  showMessage(
                    'Privacy Policy',
                    'Add your app privacy policy here.',
                  );
                },
              ),

              ProfileMenuItem(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                iconColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Delete Account?'),
                      content: const Text(
                        'This action cannot be undone. '
                            'Are you sure?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(dialogContext),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            showMessage(
                              'Delete Account',
                              'Connect your account deletion API here.',
                            );
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable menu item
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 3,
      ),
      leading: Icon(
        icon,
        color: iconColor ??
            Theme.of(context).iconTheme.color,
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ??
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
      onTap: onTap,
    );
  }
}
