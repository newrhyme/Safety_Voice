import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  final recorder = sound.FlutterSoundRecorder();
  bool isRecording = false;
  String audioPath = '';
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  List<File> recordings = [];

  @override
  void initState() {
    super.initState();
    initRecorder();
    loadRecordings();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
    isRecording = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<void> record() async {
    if (!isRecording) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future<void> stop() async {
    final path = await recorder.stopRecorder();
    audioPath = path!;

    setState(() {
      isRecording = false;
    });

    final savedFilePath = await saveRecordingLocally();
    if (savedFilePath.isNotEmpty) {
      loadRecordings();
    }
  }

  Future<String> saveRecordingLocally() async {
    if (audioPath.isEmpty) return '';

    final audioFile = File(audioPath);
    if (!audioFile.existsSync()) return '';

    try {
      final directory = await getApplicationDocumentsDirectory();
      final customDirectory = Directory(p.join(directory.path, 'recordings'));
      final newFile = File(p.join(customDirectory.path, 'audio_${DateTime.now().millisecondsSinceEpoch}.mp3'));

      if (!(await customDirectory.exists())) {
        await customDirectory.create(recursive: true);
      }

      await audioFile.copy(newFile.path);
      print('Recording saved at: ${newFile.path}');
      return newFile.path;
    } catch (e) {
      print('Error saving recording: $e');
      return '';
    }
  }

  Future<void> loadRecordings() async {
    final directory = await getApplicationDocumentsDirectory();
    final customDirectory = Directory(p.join(directory.path, 'recordings'));

    if (await customDirectory.exists()) {
      setState(() {
        recordings = customDirectory
            .listSync()
            .where((file) => file is File)
            .map((file) => file as File)
            .toList();
      });
    }
  }

  Future<void> playRecording(String path) async {
    try {
      await audioPlayer.setSourceDeviceFile(path);
      await audioPlayer.resume();
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print('Error playing recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Recordings'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                if (recorder.isRecording) {
                  await stop();
                } else {
                  await record();
                }
                setState(() {});
              },
              child: Text(recorder.isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            const SizedBox(height: 20),
            const Text('Recordings List'),
            Expanded(
              child: ListView.builder(
                itemCount: recordings.length,
                itemBuilder: (context, index) {
                  final recording = recordings[index];
                  return ListTile(
                    title: Text(recording.path.split('/').last),
                    onTap: () => playRecording(recording.path),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await recording.delete();
                        loadRecordings();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
