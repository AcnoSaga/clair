import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackcom_2021/services/authentication_service.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: 'Account',
              tiles: [
                SettingsTile(
                  title: 'Logout',
                  leading: Icon(Icons.logout),
                  onPressed: (BuildContext context) async {
                    await FirebaseAuth.instance.signOut();
                    await authenticationService.googleSignIn.disconnect();
                  },
                ),
                SettingsTile(
                  title: 'Delete Account',
                  leading: Icon(Icons.delete),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
            SettingsSection(
              title: 'Information',
              tiles: [
                SettingsTile(
                  title: 'About',
                  leading: Icon(Icons.info),
                  onPressed: (BuildContext context) {
                    showAboutDialog(
                      context: context,
                      // applicationIcon: Icon(Icons.ac_unit),
                      useRootNavigator: false,
                      applicationLegalese: 'All Rights Reserved. Clair Inc.',
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
