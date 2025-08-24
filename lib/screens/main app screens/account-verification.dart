import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/screens/main%20app%20screens/post_screen.dart';

class AccountVerificationScreen extends StatefulWidget {
  final VoidCallback ? onVerificationSuccess;

  const AccountVerificationScreen({
    Key? key,
     this.onVerificationSuccess,
  }) : super(key: key);

  @override
  State<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  String _accountType = "Private Party";
  XFile? _selectedFile;
  final ImagePicker _picker = ImagePicker();
  bool _isSubmitting = false;

  Future<void> _pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedFile = pickedFile;
    });
  }

  Future<void> _submitVerification() async {
    if (_selectedFile == null) {
     try {
     
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostScreen(
            files: [File('image.path')],
            isVideo: false,
            category: 'Car',
            isBusinessMode: false,
          ),
        ),
      );
    } catch (e) {
    
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Your Account"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Account Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text("Private Party"),
                    value: "Private Party",
                    groupValue: _accountType,
                    onChanged: (value) {
                      setState(() {
                        _accountType = value!;
                        _selectedFile = null;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text("Dealership"),
                    value: "Dealership",
                    groupValue: _accountType,
                    onChanged: (value) {
                      setState(() {
                        _accountType = value!;
                        _selectedFile = null;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Upload ${_accountType == "Private Party" ? "Government ID" : "Dealer License"}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _selectedFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(_selectedFile!.path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Center(child: Text("Tap to upload")),
              ),
            ),
            const SizedBox(height: 30),
            _isSubmitting
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.pink],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      onPressed: _submitVerification,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Verify and Continue",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
