import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:face_detection/face_detection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BiometricAndFaceDetectionDemo(),
    );
  }
}

class BiometricAndFaceDetectionDemo extends StatelessWidget {
  final LocalAuthentication localAuth = LocalAuthentication();
  final FaceDetection _faceDetection = FaceDetection();

  Future<void> authenticateWithBiometrics() async {
    try {
      final isAuthenticated = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Authenticate using biometrics',
        useErrorDialogs: true,
        stickyAuth: true,
      );

      if (isAuthenticated) {
        print('Biometric authentication successful');
      } else {
        print('Biometric authentication failed');
      }
    } catch (e) {
      print('Error during biometric authentication: $e');
    }
  }

  Future<void> detectFace() async {
    try {
      final faces = await _faceDetection.detectFaces();
      if (faces.isNotEmpty) {
        print('Face detected');
      } else {
        print('No face detected');
      }
    } catch (e) {
      print('Error during face detection: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometric & Face Detection Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: authenticateWithBiometrics,
              child: Text('Authenticate with Biometrics'),
            ),
            ElevatedButton(
              onPressed: detectFace,
              child: Text('Detect Face'),
            ),
          ],
        ),
      ),
    );
  }
}
