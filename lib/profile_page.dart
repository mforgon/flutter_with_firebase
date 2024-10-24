import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_with_firebase/language/app_localizations.dart'; // Import your localization class

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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

        await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
          'displayName': nameController.text,
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).profileUpdated)),
        );
      } catch (e) {
        setState(() {
          profileError = '${AppLocalizations.of(context).profileUpdateFailed}: $e';
        });
      }
    }
  }

  Future<void> _updatePassword() async {
    if (oldPasswordController.text.isEmpty || newPasswordController.text.isEmpty) {
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
        passwordError = '${AppLocalizations.of(context).passwordUpdateFailed}: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final profilePicUrl = user?.photoURL ?? 'assets/default_profile_pic.png';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).profile,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(profilePicUrl),
                onBackgroundImageError: (_, __) {
                  // Handle image load error
                },
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).name,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context).nameCannotBeEmpty;
                  }
                  return null;
                },
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              const SizedBox(height: 10),
              if (profileError != null)
                Text(
                  profileError!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: user?.email,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).email,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(AppLocalizations.of(context).saveProfile),
              ),
              const SizedBox(height: 40),
              Text(
                AppLocalizations.of(context).changePassword,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).oldPassword,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).newPassword,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              const SizedBox(height: 10),
              if (passwordError != null)
                Text(
                  passwordError!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updatePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(AppLocalizations.of(context).changePassword),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
