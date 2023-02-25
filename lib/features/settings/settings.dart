import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weparent/features/settings/profile.dart';
import 'package:weparent/view_model/userViewModel.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsPage2State();
}

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const CustomListTile({
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SettingsPage2State extends State<Settings> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
            title: const Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.settings),
                    ),
                  ),
                  TextSpan(text: 'Settings'),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFFBC539F),
            centerTitle: true),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                _SingleSection(
                  title: "General",
                  children: [
                    CustomListTile(
                      title: "Dark Mode",
                      icon: Icons.dark_mode_outlined,
                      trailing: Switch(
                        value: _isDark,
                        onChanged: (value) {
                          setState(() {
                            _isDark = value;
                          });
                        },
                      ),
                    ),
                    const CustomListTile(
                      title: "Notifications",
                      icon: Icons.notifications_none_rounded,
                      onTap: null,
                    ),
                    const CustomListTile(
                      title: "Security Status",
                      icon: CupertinoIcons.lock_shield,
                      onTap: null,
                    ),
                  ],
                ),
                const Divider(),
                _SingleSection(
                  title: "Organization",
                  children: [
                    CustomListTile(
                      title: "Profile",
                      icon: Icons.person_outline_rounded,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              userProfileViewModel: UserProfileViewModel(
                                  accessToken:
                                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzZjNjOTliNzI5N2FjMjNlNWY1NTBjYSIsImlhdCI6MTY3NzMyNzI4NCwiZXhwIjoxNjc3NjcyODg0fQ.bXUO6xfVOfLvVF6giHEfDAtr9nTt1HPatw5b_V4Ijkk'),
                              accessToken:
                                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzZjNjOTliNzI5N2FjMjNlNWY1NTBjYSIsImlhdCI6MTY3NzMyNzI4NCwiZXhwIjoxNjc3NjcyODg0fQ.bXUO6xfVOfLvVF6giHEfDAtr9nTt1HPatw5b_V4Ijkk',
                            ),
                          ),
                        );
                        ;
                      },
                    ),
                    CustomListTile(
                      title: "Messaging",
                      icon: Icons.message_outlined,
                      onTap: () {},
                    ),
                    CustomListTile(
                      title: "Calling",
                      icon: Icons.phone_outlined,
                      onTap: () {},
                    ),
                    CustomListTile(
                      title: "People",
                      icon: Icons.contacts_outlined,
                      onTap: () {},
                    ),
                    CustomListTile(
                      title: "Calendar",
                      icon: Icons.calendar_today_rounded,
                      onTap: () {},
                    ),
                  ],
                ),
                const Divider(),
                const _SingleSection(
                  children: [
                    CustomListTile(
                      title: "Help & Feedback",
                      icon: Icons.help_outline_rounded,
                      onTap: null,
                    ),
                    CustomListTile(
                      title: "About",
                      icon: Icons.info_outline_rounded,
                      onTap: null,
                    ),
                    CustomListTile(
                      title: "Sign out",
                      icon: Icons.exit_to_app_rounded,
                      onTap: null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}
