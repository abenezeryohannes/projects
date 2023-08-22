import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linko/src/infrastructure/chat/dtos/chat.dto.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../appcore/widgets/text.input.form.dart';
import '../../../domain/user/entities/user.entity.dart';

class ChatBottom extends StatefulWidget {
  ChatBottom(
      {super.key,
      this.user,
      required this.sendMessage,
      this.controller,
      required this.setText});
  final UserEntity? user;
  final TextEditingController? controller;
  final Function(String? x) setText;
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
  final FocusNode _focusNode = FocusNode();
  TextEditingController? controller;
  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    _initSpeech();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _focusNode.unfocus();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textInputForm = initTextForm(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * (9 / 12),
                child: initTextForm(context)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: InkWell(
                onTap: () {
                  if (_speechToText.isListening) {
                    _stopListening();
                  }
                  _focusNode.unfocus();
                  widget.sendMessage(ChatDto(
                      senderID: widget.user?.id ?? -1,
                      data: controller?.text ?? text));
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                          image: AssetImage('assets/icon/send-button.png'))),
                ),
              ))
        ],
      ),
    );
  }

  TextInputForm initTextForm(BuildContext context) {
    return TextInputForm(
      focusNode: _focusNode,
      controller: controller,
      fillColor: Theme.of(context).cardColor,
      placeholder: ('message').tr,
      maxLines: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      onChanged: (String val) {
        setState(() {
          text = val;
          _lastWords = '';
        });
      },
      textInputAction: TextInputAction.go,
      keybardType: TextInputType.text,
      initialValue: text,
      radius: 30,
      suffixIcon: InkWell(
        onTap: () {
          if (_speechToText.isNotListening) {
            _startListening();
          } else {
            _stopListening();
          }
        },
        child: Padding(
          padding:
              const EdgeInsets.only(right: 20.0, top: 5, bottom: 5, left: 20.0),
          child: (_speechToText.isNotListening)
              ? Image.asset('assets/icon/sound-wave.png',
                  width: 24, height: 24, color: Theme.of(context).disabledColor)
              : Icon(
                  Icons.stop_outlined,
                  size: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
        ),
      ),
    );
  }

  void clear() {
    if (widget.controller != null) {
      widget.setText(null);
    } else if (mounted && controller != null) {
      setState(() {
        controller!.clear();
      });
    }
    setState(() {
      text = '';
    });
  }

  void _initSpeech() async {
    if (!_speechToText.isAvailable) return;
    _lastWords = '';
    _speechToText = SpeechToText();
    await _speechToText.initialize(onStatus: (String status) {
      print('speech to text status: $status');
    }, onError: (error) {
      print('speech to text status: $error');
    });
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    // _lastWords = '';
    Future.delayed(const Duration(seconds: 30), () => _speechToText.stop());
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    _lastWords = '';
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    if (result.finalResult || true) {
      text = _lastWords;
      setEditingText(_lastWords);
    }
  }

  setEditingText(String newText) {
    if (widget.controller != null) {
      widget.setText(newText);
    } else if (controller == null) {
      return;
    }
    final updatedText = newText;
    controller!.value = controller!.value.copyWith(
      text: updatedText,
      selection: TextSelection.collapsed(offset: updatedText.length),
    );
  }
}
