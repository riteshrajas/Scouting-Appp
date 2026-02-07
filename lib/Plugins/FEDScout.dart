import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:scouting_app/components/qr_code_scanner_page.dart';
import 'package:scouting_app/services/DataBase.dart';

class FEDSScoutzWidget extends StatefulWidget {
  const FEDSScoutzWidget({super.key});

  @override
  _FEDSScoutzWidgetState createState() => _FEDSScoutzWidgetState();
}

class _FEDSScoutzWidgetState extends State<FEDSScoutzWidget> {
  final TextEditingController _controllerIp = TextEditingController();
  final TextEditingController _controllerDeviceName = TextEditingController();
  Color _testButtonColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _testConnection() async {
    String ipAddress = _controllerIp.text;
    String url = 'http://$ipAddress/alive';
    try {
      final response = await http.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        setState(() {
          _testButtonColor = Colors.green;
        });
      } else {
        setState(() {
          _testButtonColor = Colors.red;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _testButtonColor = Colors.red;
      });
    }
  }

  void _loadSettings() {
    var box = Hive.box('settings');
    String ipAddress = box.get('ipAddress', defaultValue: '');
    String deviceName = box.get('deviceName', defaultValue: '');
    _controllerIp.text = ipAddress;
    _controllerDeviceName.text = deviceName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController()
                ..text = Hive.box('settings').get('PitKey', defaultValue: ''),
              decoration: InputDecoration(
                labelText: 'Pit Key',
                labelStyle: GoogleFonts.museoModerno(fontSize: 15),
                hintText: 'Enter your Pit Key',
                hintStyle: GoogleFonts.museoModerno(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () async {
                    final qrCode = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QRCodeScannerPage(),
                          fullscreenDialog: true),
                    );
                    if (qrCode != null) {
                      setState(() {
                        Hive.box('settings').put('PitKey', qrCode);
                        Settings.setPitKey(qrCode);
                      });
                    }
                  },
                ),
              ),
              style: GoogleFonts.museoModerno(fontSize: 18),
              onSubmitted: (String value) {
                Hive.box('settings').put('PitKey', value);
                Settings.setPitKey(value);
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _testConnection,
            style: ElevatedButton.styleFrom(
              backgroundColor: _testButtonColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              elevation: 5,
              shadowColor: Colors.black.withOpacity(0.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi, size: 22, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Test',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
    ]);
  }
}
