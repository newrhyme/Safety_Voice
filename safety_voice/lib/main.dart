import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;

//   final recorder = sound.FlutterSoundRecorder();
//   bool isRecording = false;
//   String audioPath = '';
//   final AudioPlayer audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   List<File> recordings = [];

//   @override
//   void initState() {
//     super.initState();
//     initRecorder();
//     loadRecordings();
//   }

//   @override
//   void dispose() {
//     recorder.closeRecorder();
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   Future<void> initRecorder() async {
//     final status = await Permission.microphone.request();

//     if (status != PermissionStatus.granted) {
//       throw 'Microphone permission not granted';
//     }

//     await recorder.openRecorder();
//     isRecording = true;
//     recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
//   }

//   Future<void> record() async {
//     if (!isRecording) return;
//     await recorder.startRecorder(toFile: 'audio');
//   }

//   Future<void> stop() async {
//     final path = await recorder.stopRecorder();
//     audioPath = path!;

//     setState(() {
//       isRecording = false;
//     });

//     final savedFilePath = await saveRecordingLocally();
//     if (savedFilePath.isNotEmpty) {
//       loadRecordings();
//     }
//   }

//   Future<String> saveRecordingLocally() async {
//     if (audioPath.isEmpty) return '';

//     final audioFile = File(audioPath);
//     if (!audioFile.existsSync()) return '';

//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final customDirectory = Directory(p.join(directory.path, 'recordings'));
//       final newFile = File(p.join(customDirectory.path, 'audio_${DateTime.now().millisecondsSinceEpoch}.mp3'));

//       if (!(await customDirectory.exists())) {
//         await customDirectory.create(recursive: true);
//       }

//       await audioFile.copy(newFile.path);
//       print('Recording saved at: ${newFile.path}');
//       return newFile.path;
//     } catch (e) {
//       print('Error saving recording: $e');
//       return '';
//     }
//   }

//   Future<void> loadRecordings() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final customDirectory = Directory(p.join(directory.path, 'recordings'));

//     if (await customDirectory.exists()) {
//       setState(() {
//         recordings = customDirectory
//             .listSync()
//             .where((file) => file is File)
//             .map((file) => file as File)
//             .toList();
//       });
//     }
//   }

//   Future<void> playRecording(String path) async {
//     try {
//       await audioPlayer.setSourceDeviceFile(path);
//       await audioPlayer.resume();
//       setState(() {
//         isPlaying = true;
//       });
//     } catch (e) {
//       print('Error playing recording: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('Recordings'),
//         ),
//         body: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 if (recorder.isRecording) {
//                   await stop();
//                 } else {
//                   await record();
//                 }
//                 setState(() {});
//               },
//               child: Text(recorder.isRecording ? 'Stop Recording' : 'Start Recording'),
//             ),
//             const SizedBox(height: 20),
//             const Text('Recordings List'),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: recordings.length,
//                 itemBuilder: (context, index) {
//                   final recording = recordings[index];
//                   return ListTile(
//                     title: Text(recording.path.split('/').last),
//                     onTap: () => playRecording(recording.path),
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () async {
//                         await recording.delete();
//                         loadRecordings();
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//  }
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '안전한 목소리',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Noto Sans KR',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
          
              Image.asset(
                'assets/logo.png', // 법원 아이콘 이미지 필요
                height: 350,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(80.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B7AFF),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '로그인',
                          style: TextStyle(
                            
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/signup'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B7AFF),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '회원가입',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('로그인'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Column(
          children: [
             const SizedBox(height: 150),
            const TextField(
              
              decoration: InputDecoration(
                hintText: '아이디를 입력해주세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: '비밀번호를 입력해주세요',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B7AFF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                    child: const Text(
                          '로그인',
                          style: TextStyle(
                            
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('ID 찾기'),
                ),
                const Text(' | '),
                TextButton(
                  onPressed: () {},
                  child: const Text('PW 찾기'),
                ),
                const Text(' | '),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text('회원가입'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
               backgroundColor: Colors.white,

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('회원가입'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),

        child: Column(
          
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: '닉네임을 입력해주세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: '아이디를 입력해주세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: '비밀번호를 입력해주세요',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: '비밀번호를 한 번 더 입력해주세요',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: '기주 지역을 입력해주세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: '이메일을 입력해주세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B7AFF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
             child: const Text(
                          '회원가입',
                          style: TextStyle(
                            
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}