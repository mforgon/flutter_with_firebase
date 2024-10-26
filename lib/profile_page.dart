import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_with_firebase/home_page.dart';
import 'package:flutter_with_firebase/home_page_body.dart';
import 'package:flutter_with_firebase/language/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  String? profileError;
  String? passwordError;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    nameController.text = user?.displayName ?? '';
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        await user?.updateDisplayName(nameController.text);
        await user?.reload();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .set({
          'displayName': nameController.text,
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).profileUpdated)),
        );
      } catch (e) {
        setState(() {
          profileError =
              '${AppLocalizations.of(context).profileUpdateFailed}: $e';
        });
      }
    }
  }

  Future<void> _updatePassword() async {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty) {
      setState(() {
        passwordError = AppLocalizations.of(context).fillPasswordFields;
      });
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      final credential = EmailAuthProvider.credential(
        email: user?.email ?? '',
        password: oldPasswordController.text,
      );

      await user?.reauthenticateWithCredential(credential);
      await user?.updatePassword(newPasswordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).passwordUpdated)),
      );
    } catch (e) {
      setState(() {
        passwordError =
            '${AppLocalizations.of(context).passwordUpdateFailed}: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final profilePicUrl = './assets/team_member1.jpg';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0,
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(AppLocalizations.of(context).profile),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    profilePicUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).saveProfile,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context).name,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .nameCannotBeEmpty;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: user?.email,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context).email,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: _updateProfile,
                              icon: Icon(Icons.save),
                              label: Text(
                                  AppLocalizations.of(context).saveProfile),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                              ),
                            ),
                            if (profileError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  profileError!,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).changePassword,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: oldPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(context).oldPassword,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock_outline),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: newPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(context).newPassword,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: _updatePassword,
                              icon: Icon(Icons.security),
                              label: Text(
                                  AppLocalizations.of(context).changePassword),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                              ),
                            ),
                            if (passwordError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  passwordError!,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
