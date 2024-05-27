// ignore_for_file: unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_fitness/Const/common%20widgets/round_button.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  String _language = 'English';
  final List<String> _languages = <String>['English', 'Russian'];
  final GlobalKey _dropdownButtonKey = GlobalKey();

  void _openDropdown() {
    _dropdownButtonKey.currentContext?.visitChildElements((element) {
      if (element.widget is Semantics) {
        element.visitChildElements((element) {
          if (element.widget is Actions) {
            element.visitChildElements(
                (element) => Actions.invoke(element, const ActivateIntent()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // Добавляем кнопку "Назад"
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Settings', textAlign: TextAlign.center),
      ),
      body: Column(
        children: [
          Expanded(
            child: SettingsList(
              sections: [
                SettingsSection(
                  title: const Text('General',
                      style: TextStyle(color: Colors.black)),
                  tiles: <SettingsTile>[
                    SettingsTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Language'),
                      onPressed: (_) => _openDropdown(),
                      trailing: DropdownButton(
                        key: _dropdownButtonKey,
                        value: _language,
                        onChanged: (String? value) => setState(
                          () => _language = value!,
                        ),
                        items: _languages
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SettingsTile.switchTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text('Dark mode'),
                      onToggle: (bool value) =>
                          setState(() => _darkMode = value),
                      initialValue: _darkMode,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Кнопка "Accept"
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: RoundButton(
              title: "Accept",
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: media.height * 0.05,
          ),
        ],
      ),
    );
  }
}
