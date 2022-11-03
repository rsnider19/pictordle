import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pictordle/results/share_to/share_to.dart';

class HtmlShareTo implements ShareTo {
  final html.Navigator _navigator = html.window.navigator;

  @override
  Future<void> share(BuildContext context, String text) async {
    try {
      await _navigator.share({'text': text});
    } on NoSuchMethodError catch (_) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Copied to clipboard'),
            ],
          ),
          width: 175,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

HtmlShareTo getShareTo() => HtmlShareTo();
