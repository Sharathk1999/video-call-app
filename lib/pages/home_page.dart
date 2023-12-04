import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(_checkConnectSnackBar);
  }

  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Video Call'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const AvatarGlow(
                    startDelay: Duration(seconds: 2),
                    glowColor: Colors.blueGrey,
                    endRadius: 120,
                    showTwoGlows: true,
                    animate: true,
                    child: CircleAvatar(
                      radius: 90,
                      child: Icon(
                        Icons.video_chat_rounded,
                        color: Colors.blueGrey,
                        size: 80,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        hintText: 'Enter name'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        hintText: 'Enter call id'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Connectivity().checkConnectivity();
                      _checkConnectSnackBar(result);
                      var uuid = const Uuid();
                      String userID =
                          '${_nameController.text.trim()}${uuid.v4()}';
                      if (!context.mounted) return;
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
                      _idController.clear();
                      _nameController.clear();
                    },
                    icon: const Icon(Icons.call),
                    label: const Text('Call'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _checkConnectSnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? result == ConnectivityResult.mobile
            ? 'Connected to mobile network'
            : 'Connected to wifi network'
        : 'No internet connection';
    final color = hasInternet ? Colors.green : Colors.red;
    _showSnackbar(context, message, color);
  }

  void _showSnackbar(BuildContext context, String? message, Color color) {
    final snackBar = SnackBar(
      content: Text(message!),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
