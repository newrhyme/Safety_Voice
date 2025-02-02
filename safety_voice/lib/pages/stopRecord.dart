import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class StopRecord extends StatefulWidget {
  const StopRecord({super.key});

  @override
  State<StopRecord> createState() => _StopRecordState();
}

class _StopRecordState extends State<StopRecord> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool _isRecorderInitialized = false; // Recorder 초기화 상태
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    try {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        print('Microphone permission not granted');
        throw RecordingPermissionException('Microphone permission not granted');
      }
      await _recorder.openRecorder();
      _isRecorderInitialized = true; // 초기화 완료 상태로 설정
      print('Recorder initialized');
    } catch (e) {
      print('Error initializing recorder: $e');
    }
  }

  Future<void> _startRecording() async {
    try {
      if (!_isRecorderInitialized) {
        print('Recorder is not initialized');
        throw Exception('Recorder is not initialized');
      }
      final dir = await getApplicationDocumentsDirectory();
      _filePath = '${dir.path}/recorded_audio.aac';
      await _recorder.startRecorder(toFile: _filePath);
      print('Recording started');
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _recorder.stopRecorder();
      print('Recording stopped');
      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  @override
  void dispose() {
    if (_recorder.isRecording) {
      _recorder.stopRecorder();
    }
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // AppBar 높이를 80으로 설정
        child: AppBar(
          backgroundColor: Colors.white,
          title: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/listhome'),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/back.png', // back.png 이미지
                  height: 24, // 이미지 높이
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/record.png', width: 200, height: 200),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isRecording ? Colors.red : Colors.green,
              ),
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            if (_filePath != null && !_isRecording)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Recording saved at: $_filePath'),
              ),
          ],
        ),
      ),
    );
  }
}
