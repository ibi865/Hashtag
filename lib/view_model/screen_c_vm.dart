import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_vm.dart';
import '../config/app_routes.dart';

class ScreenCVm extends BaseViewModel {
  final TextEditingController phraseController = TextEditingController();
  final TextEditingController hashtagsController = TextEditingController();
  final FocusNode phraseFocusNode = FocusNode();
  final FocusNode hashtagsFocusNode = FocusNode();

  ScreenCVm() {
    phraseController.addListener(_onPhraseChanged);
    hashtagsController.addListener(_onHashtagsChanged);
  }

  void _onPhraseChanged() {
    if (!hashtagsFocusNode.hasFocus) {
      _updateHashtagsFromPhrase();
    }
  }

  void _onHashtagsChanged() {
    // Allow manual editing of hashtags
  }

  void _updateHashtagsFromPhrase() {
    final phrase = phraseController.text;
    final hashtagRegex = RegExp(r'#\w+');
    final matches = hashtagRegex.allMatches(phrase);
    
    final extractedHashtags = matches.map((match) => match.group(0)!).toSet().toList();
    final hashtagsText = extractedHashtags.join(' ');

    if (hashtagsController.text != hashtagsText) {
      hashtagsController.text = hashtagsText;
    }
  }

  void submit(BuildContext context) {
    final phrase = phraseController.text;
    final hashtags = hashtagsController.text;
    
    context.pop();
    context.pushReplacement(
      '${AppRoutes.screenB}?phrase=${Uri.encodeComponent(phrase)}&hashtags=${Uri.encodeComponent(hashtags)}',
    );
  }

  @override
  void dispose() {
    phraseController.removeListener(_onPhraseChanged);
    hashtagsController.removeListener(_onHashtagsChanged);
    phraseController.dispose();
    hashtagsController.dispose();
    phraseFocusNode.dispose();
    hashtagsFocusNode.dispose();
    super.dispose();
  }
}

