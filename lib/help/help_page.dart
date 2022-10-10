import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictordle/core/shared_pref_keys.dart';
import 'package:pictordle/help/help_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({
    super.key,
  });

  static const routeName = '/help';

  static Route<HelpPage> route() {
    return MaterialPageRoute(
      builder: (context) => const HelpPage(),
      settings: const RouteSettings(
        name: routeName,
      ),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        unawaited(
          context.read<SharedPreferences>().setBool(SharedPrefKeys.helpPageViewed.name, true),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const CloseButton(color: Colors.black),
          title: const Text(
            'How to play',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: const HelpContent(),
        ),
      ),
    );
  }
}
