import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // Dapatkan token FCM
    _getFCMToken();
  }

  void _getFCMToken() async {
    String? token = await _messaging.getToken();
    print("FCM Token: $token");

    // Anda bisa menyimpan token ini di server atau untuk digunakan nanti
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FCM Token Example')),
      body: Center(child: Text('FCM Token telah diambil, cek konsol')),
    );
  }
}
