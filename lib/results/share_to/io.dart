import 'package:flutter/widgets.dart';
import 'package:pictordle/results/share_to/share_to.dart';
import 'package:share_plus/share_plus.dart';

class IoShareTo with WidgetsBindingObserver implements ShareTo {
  @override
  Future<void> share(BuildContext context, String text) async {
    await Share.share(text);
  }
}

IoShareTo getShareTo() => IoShareTo();
