import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weparent/utils/themeManager.dart';

import 'package:weparent/view/settings/manageAccount/manageaccount_screen.dart';
import 'package:weparent/viewmodel/userViewModel.dart';

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
  late SharedPreferences prefs;
  String? token;

  Future<void> logout() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/welcome'));
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      token = prefs.getString('token');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeManager>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;  
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
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
          foregroundColor: const Color(0xFFBC539F),
          centerTitle: true),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(
                  'Assets/settings.png', // replace with your own image path
                  height: 190,

                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              _SingleSection(
                title: "General",
                children: [
                  CustomListTile(
                    title: "Dark Mode",
                    icon: Icons.dark_mode_outlined,
                    trailing: Switch(
                      inactiveThumbColor: const Color(0xFFBC539F) ,
                      activeColor:const Color(0xFFBC539F) ,
                      value: isDarkMode,
                       onChanged: (value) {
        if (value) {
          themeProvider.setThemeMode(ThemeMode.dark);
        } else {
          themeProvider.setThemeMode(ThemeMode.light);
        }
      },
                    ),
                  ),
                  const CustomListTile(
                    title: "Notifications",
                    icon: Icons.notifications_none_rounded,
                    onTap: null,
                  ),
                ],
              ),
              Divider(thickness: 1),
              _SingleSection(
                title: "Organization",
                children: [
                  CustomListTile(
                    title: "Manage account",
                    icon: Icons.person_outline_rounded,
                    onTap: () {
                      Navigator.pushNamed(context, "/manageaccount");
                    },
                  ),
                  CustomListTile(
                    title: "Alerts",
                    icon: Icons.crisis_alert,
                    onTap: () {},
                  ),
                  CustomListTile(
                    title: "Advanced",
                    icon: Icons.settings_ethernet,
                    onTap: () {},
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              _SingleSection(
                title: "Other",
                children: [
                  const CustomListTile(
                    title: "Help & Feedback",
                    icon: Icons.help_outline_rounded,
                    onTap: null,
                  ),
                  const CustomListTile(
                    title: "About",
                    icon: Icons.info_outline_rounded,
                    onTap: null,
                  ),
                  CustomListTile(
                    title: "Sign out",
                    icon: Icons.exit_to_app_rounded,
                    onTap: (() {
                      logout();
                    }),
                  ),
                ],
              ),
            ],
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                title!,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          Column(
            children: children,
          ),
        ],
      ),
    );
  }
}
