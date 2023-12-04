import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:video_call/pages/video_call_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter Id'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    var uuid = Uuid();
                    String userID = '${_nameController.text.trim()}${uuid.v4()}';
                    print(userID);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallPage(
                          callID: _idController.text.trim(),
                          userName: _nameController.text.trim(),
                          userID: userID,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.call),
                  label: const Text('Call'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
