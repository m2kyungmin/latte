import 'package:flutter/material.dart';
import 'package:latte/size_config.dart';
import 'package:settings_ui/settings_ui.dart';

bool vibration = false;

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // initialize
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(40),
            horizontal: getProportionateScreenWidth(5)),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: const Text(
                '공통',
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.language),
                  title: const Text('언어'),
                  value: const Text('한국어'),
                  onPressed: ((context) {}),
                ),
                SettingsTile.switchTile(
                  title: const Text('진동'),
                  initialValue: vibration,
                  onToggle: (value) {
                    setState(() {
                      vibration = !vibration;
                    });
                  },
                  leading: const Icon(Icons.vibration),
                ),
              ],
            ),
            SettingsSection(
              title: const Text('계정'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.logout),
                  title: const Text('로그아웃'),
                  onPressed: ((context) {}),
                ),
              ],
            ),
            SettingsSection(
              title: const Text('기타'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.star),
                  title: const Text('앱 평가하기'),
                  onPressed: ((context) {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
