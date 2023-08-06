import 'package:flutter/material.dart';
import 'package:linko/src/infrastructure/chat/dtos/chat.dto.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../appcore/widgets/text.input.form.dart';
import '../../../domain/user/entities/user.entity.dart';

class ChatBottom extends StatefulWidget {
  ChatBottom({super.key, this.user, required this.sendMessage});
  final UserEntity? user;
  final Function(ChatDto) sendMessage;
  final state = _ChatBottomState();
  @override
  State<ChatBottom> createState() => state;

  void clear() {
    state.clear();
  }
}

class _ChatBottomState extends State<ChatBottom> {
  String text = '';
  TextInputForm? textInputForm;
  SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';

  @override
  void initState() {
    _initSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textInputForm ??= initTextForm(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * (9 / 12),
              child: textInputForm),
        ),
        Material(
            color: _speechToText.isNotListening
                ? Theme.of(context).colorScheme.secondary
                : Colors.green,
            elevation: 1,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: IconButton(
                onPressed: () {
                  widget.sendMessage(
                      ChatDto(senderID: widget.user?.id ?? -1, data: text));
                },
                icon: Transform.rotate(
                  angle: _speechToText.isNotListening ? -.50 : 0,
                  child: Icon(
                    _speechToText.isNotListening
                        ? Icons.send
                        : Icons.graphic_eq,
                    color: _speechToText.isNotListening
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.background,
                  ),
                )))
      ],
    );
  }

  TextInputForm initTextForm(BuildContext context) {
    return TextInputForm(
      fillColor: Theme.of(context).cardColor,
      placeholder: 'Message',
      maxLines: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      onChanged: (String val) {
        setState(() {
          text = val;
        });
      },
      initialValue: text,
      radius: 30,
      suffixIcon: InkWell(
        onTap: // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        child: Icon(
          Icons.graphic_eq,
          color: _speechToText.isNotListening
              ? Theme.of(context).dividerColor
              : Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  void clear() {
    if (mounted) {
      setState(() {
        textInputForm?.clear();
      });
    }
  }

  void _initSpeech() async {
    _speechToText = SpeechToText();
    await _speechToText.initialize(onStatus: (String status) {
      print(status);
    }, onError: (error) {
      print(error);
    });
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    Future.delayed(const Duration(seconds: 30), () => _speechToText.stop());
    setState(() {
      _lastWords = result.recognizedWords;
    });
    if (result.finalResult || true) {
      textInputForm?.clear();
      textInputForm?.setValue(_lastWords);
    }
  }
}
