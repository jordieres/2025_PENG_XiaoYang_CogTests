import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/user_profile.dart';
import '../contoller/user_profile_controller.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController searchUserIdController = TextEditingController(); // Separate controller for search

  Sex? selectedSex;
  DateTime? selectedBirthDate;
  EducationLevel? selectedEducationLevel;

  String profileInfo = '';
  bool isLoading = false;

  late UserProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<UserProfileController>();
  }

  @override
  void dispose() {
    userIdController.dispose();
    nicknameController.dispose();
    searchUserIdController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedBirthDate) {
      setState(() {
        selectedBirthDate = picked;
      });
    }
  }

  Future<void> saveUser() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields correctly.')),
      );
      return;
    }
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newUserProfile = UserProfile(
        userId: userIdController.text,
        nickname: nicknameController.text,
        sex: selectedSex!,
        birthDate: selectedBirthDate!,
        educationLevel: selectedEducationLevel!,
      );

      // Optional: Check if userId already exists before saving
      // final existingProfile = await controller.getProfileByUserId(newUserProfile.userId);
      // if (existingProfile != null) {
      //    if (!mounted) return;
      //    ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('User ID ${newUserProfile.userId} already exists.')),
      //   );
      //   setState(() => isLoading = false );
      //   return;
      // }


      await controller.saveProfile(newUserProfile);

      if (!mounted) return;

      userIdController.clear();
      nicknameController.clear();
      setState(() {
        selectedSex = null;
        selectedBirthDate = null;
        selectedEducationLevel = null;
      });
      _formKey.currentState!.reset(); // Reset form validation state


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User profile saved successfully!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save user profile: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> getProfile() async {
    if (searchUserIdController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a User ID to search.')),
      );
      return;
    }
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final UserProfile? profile =
      await controller.getProfileByUserId(searchUserIdController.text);

      if (!mounted) return;

      setState(() {
        if (profile != null) {
          profileInfo = '''
User ID: ${profile.userId}
Nickname: ${profile.nickname}
Sex: ${profile.sex.toString().split('.').last}
Birth Date: ${DateFormat('yyyy-MM-dd').format(profile.birthDate)}
Education Level: ${profile.educationLevel.toString().split('.').last}
''';
        } else {
          profileInfo = 'No profile found for this User ID: ${searchUserIdController.text}';
        }
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get profile: $e')),
      );
      setState(() {
        profileInfo = 'Error fetching profile.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register New User',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: userIdController,
                decoration: const InputDecoration(
                  labelText: 'User ID *',
                  border: OutlineInputBorder(),
                  hintText: 'Enter a unique user identifier',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'User ID cannot be empty';
                  }
                  // Add more validation if needed (e.g., length, characters)
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: nicknameController,
                decoration: const InputDecoration(
                  labelText: 'Nickname *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nickname cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Sex>(
                value: selectedSex,
                decoration: const InputDecoration(
                  labelText: 'Sex *',
                  border: OutlineInputBorder(),
                ),
                items: Sex.values.map((Sex sex) {
                  return DropdownMenuItem<Sex>(
                    value: sex,
                    child: Text(sex.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (Sex? newValue) {
                  setState(() {
                    selectedSex = newValue;
                  });
                },
                validator: (value) => value == null ? 'Please select sex' : null,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Birth Date *',
                    border: const OutlineInputBorder(),
                    // Show error style if validation fails
                    errorText: _formKey.currentState?.validate() == false && selectedBirthDate == null
                        ? 'Please select birth date'
                        : null,
                  ),
                  child: Text(
                    selectedBirthDate == null
                        ? 'Select Date'
                        : DateFormat('yyyy-MM-dd').format(selectedBirthDate!),
                  ),
                ),
              ),
              // Hidden TextFormField for birth date validation within the Form
              Visibility(
                visible: false,
                maintainState: true,
                child: TextFormField(
                  initialValue: selectedBirthDate?.toIso8601String(),
                  validator: (value) => selectedBirthDate == null ? '' : null, // Trigger validation
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<EducationLevel>(
                value: selectedEducationLevel,
                decoration: const InputDecoration(
                  labelText: 'Education Level *',
                  border: OutlineInputBorder(),
                ),
                items: EducationLevel.values.map((EducationLevel level) {
                  return DropdownMenuItem<EducationLevel>(
                    value: level,
                    child: Text(level.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (EducationLevel? newValue) {
                  setState(() {
                    selectedEducationLevel = newValue;
                  });
                },
                validator: (value) => value == null ? 'Please select education level' : null,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: isLoading ? null : saveUser,
                  child: isLoading
                      ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Save User'),
                ),
              ),

              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 24),

              Text(
                'Get User Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: searchUserIdController, // Use separate controller here
                decoration: const InputDecoration(
                  labelText: 'User ID to Search',
                  border: OutlineInputBorder(),
                  hintText: 'Enter User ID to fetch profile',
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: isLoading ? null : getProfile,
                  child: isLoading
                      ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Get Profile'),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: profileInfo.isEmpty
                    ? Text(
                  'Enter a User ID and click "Get Profile" to view information.',
                  style: TextStyle(color: Theme.of(context).hintColor),
                )
                    : Text(profileInfo),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}