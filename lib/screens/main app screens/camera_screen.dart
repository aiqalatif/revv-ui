import 'dart:io';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/screens/main%20app%20screens/post_screen.dart';


class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  int selectedCameraIndex = 0;
  bool isRecording = false;
  bool isFlashOn = false;
  bool isGridVisible = false;
  Timer? recordingTimer;
  int recordingDuration = 0;
  ResolutionPreset currentResolution = ResolutionPreset.high;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        controller = CameraController(
          cameras![selectedCameraIndex],
          currentResolution,
          enableAudio: true,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );
        await controller!.initialize();
        if (mounted) setState(() {});
      }
    } catch (e) {
      _showErrorDialog('Camera Error', 'Failed to initialize camera: $e');
    }
  }

  void switchCamera() {
    if (cameras != null && cameras!.length > 1) {
      selectedCameraIndex = selectedCameraIndex == 0 ? 1 : 0;
      initCamera();
    }
  }

  void toggleFlash() async {
    if (controller != null && controller!.value.isInitialized) {
      try {
        if (isFlashOn) {
          await controller!.setFlashMode(FlashMode.off);
        } else {
          await controller!.setFlashMode(FlashMode.torch);
        }
        setState(() => isFlashOn = !isFlashOn);
      } catch (e) {
        _showErrorDialog('Flash Error', 'Failed to toggle flash: $e');
      }
    }
  }

  void toggleGrid() {
    setState(() => isGridVisible = !isGridVisible);
  }

  void changeResolution() {
    final resolutions = [
      ResolutionPreset.low,
      ResolutionPreset.medium,
      ResolutionPreset.high,
      ResolutionPreset.veryHigh,
      ResolutionPreset.ultraHigh,
    ];
    
    final currentIndex = resolutions.indexOf(currentResolution);
    final nextIndex = (currentIndex + 1) % resolutions.length;
    
    setState(() => currentResolution = resolutions[nextIndex]);
    initCamera();
  }

  Future<void> takePicture() async {
    if (!controller!.value.isInitialized) return;
    
    try {
      final image = await controller!.takePicture();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>PostCarScreen()
        ),
      );
    } catch (e) {
      _showErrorDialog('Photo Error', 'Failed to take picture: $e');
    }
  }

  Future<void> startVideoRecording() async {
    if (!controller!.value.isInitialized) return;
    
    try {
      await controller!.startVideoRecording();
      setState(() => isRecording = true);
      
      recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() => recordingDuration++);
      });
    } catch (e) {
      _showErrorDialog('Recording Error', 'Failed to start recording: $e');
    }
  }

  Future<void> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) return;
    
    try {
      final video = await controller!.stopVideoRecording();
      recordingTimer?.cancel();
      setState(() {
        isRecording = false;
        recordingDuration = 0;
      });
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>PostCarScreen()
        ),
      );
    } catch (e) {
      _showErrorDialog('Recording Error', 'Failed to stop recording: $e');
    }
  }

  Future<void> pickMultipleImages() async {
    try {
      final picker = ImagePicker();
      final pickedFiles = await picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostCarScreen()
          ),
        );
      }
    } catch (e) {
      _showErrorDialog('Gallery Error', 'Failed to pick images: $e');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    recordingTimer?.cancel();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Initializing Camera...'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Camera Preview
          CameraPreview(controller!),

          // Grid Overlay
          if (isGridVisible) _buildGridOverlay(),

          // Top Controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close Button
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 24),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // Right Controls
                Row(
                  children: [
                    // Grid Toggle
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isGridVisible ? Colors.blue : Colors.black54,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.grid_on,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: toggleGrid,
                      ),
                    ),

                    // Flash Toggle
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isFlashOn ? Colors.yellow : Colors.black54,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isFlashOn ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: toggleFlash,
                      ),
                    ),

                    // Switch Camera
                    if (cameras != null && cameras!.length > 1)
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.cameraswitch,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: switchCamera,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Recording Timer
          if (isRecording)
            Positioned(
              top: MediaQuery.of(context).padding.top + 80,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDuration(recordingDuration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Bottom Controls
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Main Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Gallery Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: pickMultipleImages,
                      ),
                    ),

                    // Capture / Video Button
                    GestureDetector(
                      onLongPress: startVideoRecording,
                      onLongPressUp: stopVideoRecording,
                      onTap: takePicture,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: isRecording ? Colors.red : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isRecording ? Colors.red : Colors.white70,
                            width: 4,
                          ),
                        ),
                        child: Icon(
                          isRecording ? Icons.stop : Icons.camera,
                          color: isRecording ? Colors.white : Colors.black87,
                          size: 32,
                        ),
                      ),
                    ),

                    // Settings Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: changeResolution,
                      ),
                    ),
                  ],
                ),

                // Resolution Indicator
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '${currentResolution.name.toUpperCase()}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridOverlay() {
    return CustomPaint(
      painter: GridPainter(),
      size: Size.infinite,
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 0.5;

    // Vertical lines
    for (int i = 1; i < 3; i++) {
      final x = size.width * i / 3;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (int i = 1; i < 3; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
