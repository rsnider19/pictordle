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

  static Future<void> open(BuildContext context) async {
    final sharedPrefs = context.read<SharedPreferences>();

    await showDialog<void>(
      context: context,
      builder: (_) => const HelpPage(),
    );

    unawaited(
      sharedPrefs.setBool(
        SharedPrefKeys.helpPageViewed.name,
        true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text(
                  'How to play',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              CloseButton(color: Colors.black),
            ],
          ),
          const Divider(
            height: 1,
            indent: 24,
            endIndent: 24,
          ),
        ],
      ),
      content: const HelpContent(),
    );
  }
}
