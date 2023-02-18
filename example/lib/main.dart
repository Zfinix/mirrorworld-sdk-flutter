import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mirror_world_flutter/mirror_world_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _mirrorWorld = MirrorWorldFlutter.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      await _mirrorWorld.initialize(
          apiKey: 'mw_KnWBjjEM4iV7Qy6epkcmdUlljJUlmC1Cs23');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            MirrorButton(
              text: 'Open Wallet',
              onPressed: () async {
                await _mirrorWorld.openWallet();
              },
            ),
            MirrorButton(
              text: 'Start Login',
              onPressed: () async {
                await _mirrorWorld.startLogin();
              },
            ),
            MirrorButton(
              text: 'Login With Email',
              onPressed: () async {
                await _mirrorWorld.loginWithEmail(
                  email: 'zfinix14@gmail.com',
                  password: '1234',
                );
              },
            ),
            MirrorButton(
              text: 'guestLogin',
              onPressed: () async {
                await _mirrorWorld.guestLogin();
              },
            ),
            MirrorButton(
              text: 'logOut',
              onPressed: () async {
                await _mirrorWorld.logOut();
              },
            ),
            MirrorButton(
              text: 'openMarket',
              onPressed: () async {
                await _mirrorWorld.openMarket(
                    marketUrl: 'https://jump-devnet.mirrorworld.fun');
              },
            ),
            MirrorButton(
              text: 'openUrl',
              onPressed: () async {
                await _mirrorWorld.openUrl(url: 'https://twitter.com');
              },
            ),
            MirrorButton(
              text: 'fetchUser',
              onPressed: () async {
                await _mirrorWorld.fetchUser();
              },
            ),
            MirrorButton(
              text: 'queryUser',
              onPressed: () async {
                await _mirrorWorld.queryUser(email: 'zfinix14@gmail.com');
              },
            ),
            MirrorButton(
              text: 'getTokens',
              onPressed: () async {
                await _mirrorWorld.getTokens();
              },
            ),
            MirrorButton(
              text: 'getTransactions',
              onPressed: () async {
                await _mirrorWorld.getTransactions(
                    before:
                        'bvcofigBLTmy3DJ29P8Nfh5aJ1GHwS6ncSmTBZdYGfXCs2e5pvY7nV8zBXYefoeczggVXEkKAkNy1GAZPpHhmWi');
              },
            ),
            MirrorButton(
              text: 'getTransaction',
              onPressed: () async {
                await _mirrorWorld.getTransaction(
                    signature:
                        'bvcofigBLTmy3DJ29P8Nfh5aJ1GHwS6ncSmTBZdYGfXCs2e5pvY7nV8zBXYefoeczggVXEkKAkNy1GAZPpHhmWi');
              },
            ),
            MirrorButton(
              text: 'getNFTDetails',
              onPressed: () async {
                await _mirrorWorld.getNFTDetails(
                    mintAddress:
                        'BP3KqTZbyPsbGtYKGbbvbbheZW6H6V3wGooV8dj5RRVB');
              },
            ),
            MirrorButton(
              text: 'getNFTsOwnedByAddress',
              onPressed: () async {
                await _mirrorWorld.getNFTsOwnedByAddress(
                    ownerWalletAddress: 'getNFTsOwnedByAddress');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MirrorButton extends StatelessWidget {
  const MirrorButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MaterialButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
