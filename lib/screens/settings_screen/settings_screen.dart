import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      backgroundColor: Color(0xFF0E0E0E),
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF1D1D1D),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
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
                  onPressed: (context) => _deleteDialog(),
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

  Future _deleteDialog() async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    await Get.dialog(
      Form(
        key: _formKey,
        child: AlertDialog(
          title: Text(
              'Are you sure you want to delete your account?\nThis action can not be reversed.'),
          actions: [
            TextButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.currentUser?.delete();
                await authenticationService.googleSignIn.disconnect();
              },
              icon: Icon(
                Icons.check_circle,
                color: Colors.red,
              ),
              label: Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton.icon(
              onPressed: Get.back,
              icon: Icon(
                Icons.cancel,
                color: Colors.green,
              ),
              label: Text(
                'No',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
