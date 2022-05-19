import 'package:avatar_glow/avatar_glow.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../Model/APIs/Dummy/dummy_places.dart';
import '../../Utils/utils.dart';

class VoiceSearchPage extends StatefulWidget {
  const VoiceSearchPage({Key? key}) : super(key: key);

  @override
  _VoiceSearchPageState createState() => _VoiceSearchPageState();
}

class _VoiceSearchPageState extends State<VoiceSearchPage> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _isSearching = false;
  String _recognizedText = '';

  List<Map<String, String>> filterList = [];

  @override
  void initState() {
    _handleMicPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 700,
        ),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: !_isSearching && _recognizedText.isNotEmpty
            ? SingleChildScrollView(
                reverse: true,
                padding: const EdgeInsets.all(
                  32,
                ),
                child: Text(
                  _recognizedText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
            : !_isSearching
                ? Center(
                    child: Text(
                      _isListening ? 'Try Speaking...' : 'Tap To Speak',
                      style: TextStyle(
                        color: Colors.grey.shade600.withOpacity(
                          0.6,
                        ),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  )
                : filterList.isNotEmpty
                    ? Material(
                        color: Colors.transparent,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(
                            top: 24,
                          ),
                          itemCount: filterList.length,
                          separatorBuilder: (context, index) => Divider(
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.pop(context,
                                    "${filterList[index]["address"]} ${filterList[index]["gov"]}");
                              },
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 28,
                              ),
                              title: Text(
                                filterList[index]["name"]!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  "${filterList[index]["address"]!}\n${filterList[index]["gov"]!}"),
                              isThreeLine: true,
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text('No Results'),
                      ),
      ),
      // body: AnimatedSwitcher(
      //   duration: const Duration(
      //     milliseconds: 700,
      //   ),
      //   transitionBuilder: (child, animation) => FadeTransition(
      //     opacity: animation,
      //     child: child,
      //   ),
      //   child: _recognizedText.isNotEmpty && !_isSearching
      //       ? SingleChildScrollView(
      //           reverse: true,
      //           child: Text(
      //             _recognizedText,
      //           ))
      //       : !_isSearching
      //           ? const Center(
      //               child: Text('Tap To Listen'),
      //             )
      //           : filterList.isNotEmpty
      //               ? Material(
      //                   color: Colors.transparent,
      //                   child: ListView.separated(
      //                     padding: const EdgeInsets.only(
      //                       top: 24,
      //                     ),
      //                     itemCount: filterList.length,
      //                     separatorBuilder: (context, index) => Divider(
      //                       thickness: 1,
      //                     ),
      //                     itemBuilder: (context, index) {
      //                       return ListTile(
      //                         onTap: () {
      //                           Navigator.pop(context,
      //                               "${filterList[index]["address"]} ${filterList[index]["gov"]}");
      //                         },
      //                         leading: Icon(
      //                           Icons.location_on,
      //                           color: Colors.red,
      //                           size: 28,
      //                         ),
      //                         title: Text(
      //                           filterList[index]["name"]!,
      //                           style: const TextStyle(
      //                               fontWeight: FontWeight.bold),
      //                         ),
      //                         subtitle: Text(
      //                             "${filterList[index]["address"]!}\n${filterList[index]["gov"]!}"),
      //                         isThreeLine: true,
      //                       );
      //                     },
      //                   ),
      //                 )
      //               : const Center(
      //                   child: Text('No Results'),
      //                 ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75,
        animate: _isListening,
        duration: const Duration(seconds: 2),
        glowColor: Colors.red,
        child: AnimatedScale(
          scale: _isListening ? 1.5 : 1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.bounceInOut,
          child: FloatingActionButton(
            child: !_isListening && _recognizedText.isNotEmpty && !_isSearching
                ? Icon(Icons.search)
                : !_isListening && _recognizedText.isNotEmpty && _isSearching
                    ? Icon(Icons.close)
                    : Icon(Icons.mic),
            foregroundColor: _isListening || _recognizedText.isNotEmpty
                ? Colors.white
                : Colors.red,
            backgroundColor: !_isListening &&
                    _recognizedText.isNotEmpty &&
                    _isSearching
                ? Colors.black
                : !_isListening && _recognizedText.isNotEmpty && !_isSearching
                    ? Colors.blue
                    : !_isListening && !_isSearching
                        ? Colors.white
                        : Colors.red,
            onPressed: _listen,
          ),
        ),
      ),
    );
  }

  void _listen() async {
    ConnectivityResult _connectivity = await Connectivity().checkConnectivity();
    if (_connectivity == ConnectivityResult.none){
      Utils.showConnectionError(context);
      return;
    }
    PermissionStatus status = await Permission.microphone.status;
    if (status == PermissionStatus.denied)
      _handleMicPermission();
    if (!_isListening) {
      if (_recognizedText.isNotEmpty && !_isSearching) {
        setState(() {
          _isSearching = true;
          _filter();
        });
        return;
      }
      if (_isSearching) {
        setState(() {
          _isSearching = false;
          _recognizedText = '';
          filterList = [];
        });
        return;
      }
      bool available = await _speech.initialize(
          //finalTimeout: const Duration(minutes: 1),
          onStatus: (status) async {
        if (status != 'listening') {
          await _speech.stop();
          setState(() {
            _isListening = false;
          });
        }
        else{
          _connectivity = await Connectivity().checkConnectivity();
          if (_connectivity == ConnectivityResult.none) {
            Utils.showConnectionError(context);
            await _speech.stop();
            setState(() {
              _isListening = false;
            });
          }
        }
      });
      if (available) {
        setState(() {
          _isListening = true;
          //_recognizedText = '';
        });
        await _speech
            .listen(
          localeId: 'ar',
          onResult: (result) {
            _recognizedText = result.recognizedWords;
            setState(() {});
          },
        )
            .timeout(const Duration(seconds: 3), onTimeout: () async {
          await _speech.stop();
          setState(() {
            _isListening = false;
          });
        });
      }
    } else {
      await _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  void _filter() {
    filterList = placesList.where((element) {
      bool condition = element["name"]!.startsWith(_recognizedText) ||
          element["address"]!.startsWith(_recognizedText) ||
          element["gov"]!.startsWith(_recognizedText) ||
          _recognizedText.contains(element["name"]!) ||
          _recognizedText.contains(element["address"]!) ||
          _recognizedText.contains(element["gov"]!);
      return condition;
    }).toList();
  }

  Future<void> _handleMicPermission() async {
    PermissionStatus status = await Permission.microphone.status;
    if (status == PermissionStatus.denied)
      status = await Permission.microphone.request();
    switch (status) {
      case PermissionStatus.granted:
        return;
      case PermissionStatus.denied:
        bool? request = await Utils.showPermissionErrorAndRequest(context,permissionType: 'Microphone');
        if (request == null || !request)
          Navigator.pop(context);
        else {
          PermissionStatus newStatus = await Permission.microphone.request();
          if (newStatus != PermissionStatus.granted) Navigator.pop(context);
        }
        break;
      case PermissionStatus.permanentlyDenied:
        await showDialog(
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text('Permission Error'),
            content: const Text(
                'Cannot Access Microphone Services In Your Device.Please Enable Service From App Settings To Continue'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, true);
                },
                child: const Text('Ok'),
              ),
            ],
          ),
          context: context,
        );
        Navigator.pop(context);
    }
  }
}
