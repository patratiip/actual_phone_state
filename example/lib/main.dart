import 'package:actual_phone_state/actual_phone_state.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PhoneStateExamplePage(),
    );
  }
}

class PhoneStateExamplePage extends StatefulWidget {
  const PhoneStateExamplePage({super.key});

  @override
  State<PhoneStateExamplePage> createState() => _PhoneStateExamplePageState();
}

class _PhoneStateExamplePageState extends State<PhoneStateExamplePage> {
  String _stateText = 'Unknown';

  Future<void> _checkPhoneState() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      final permission = await Permission.phone.request();
      if (!permission.isGranted) {
        setState(() {
          _stateText = 'Permission denied';
        });
        return;
      }
    }

    final state = await ActualPhoneState.getPhoneState();

    setState(() {
      _stateText = switch (state) {
        ActualPhoneStateStatus.callActive => 'Call active',
        ActualPhoneStateStatus.noCall => 'No call',
        ActualPhoneStateStatus.unknown => 'Unknown',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actual Phone State Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _stateText,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _checkPhoneState,
                child: const Text('Check phone state'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
