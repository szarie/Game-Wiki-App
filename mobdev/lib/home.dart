import 'package:flutter/material.dart';
import 'package:mobdev/nav.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isPaused = false;
  // List of video files
  final List<String> videoFiles = [
    'assets/vids/miyabi.mp4',
    'assets/vids/soldier0.mp4',
    'assets/vids/vivian.mp4',
  ];

  int _currentCarouselIndex = 0;
  List<VideoPlayerController> _controllers = [];
  Timer? _videoTimer;

  @override
  void initState() {
    super.initState();
    // Initialize video controllers
    _initializeControllers();
  }

  void _initializeControllers() {
    // Create controllers for each video
    _controllers = videoFiles.map((file) {
      final controller = VideoPlayerController.asset(file);
      controller.initialize().then((_) {
        // Ensure the first video starts playing when ready
        if (videoFiles.indexOf(file) == 0) {
          controller.play();
          controller.setLooping(true);
        }
        // This will rebuild the widget after initialization
        if (mounted) setState(() {});
      });
      return controller;
    }).toList();
  }

  @override
  void dispose() {
    // Clean up all controllers
    for (var controller in _controllers) {
      controller.dispose();
    }
    _videoTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 0,
      showAppBar: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Video Carousel
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Stack(
                children: [
                  // Carousel with Videos
                  CarouselSlider(
                    items: _controllers.map((controller) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                        child: controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: controller.value.aspectRatio,
                                child: VideoPlayer(controller),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 250,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      autoPlay: !_isPaused,
                      autoPlayInterval: Duration(seconds: 10),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarouselIndex = index;

                          // Stop all videos
                          for (var controller in _controllers) {
                            controller.pause();
                          }

                          // Play only the current video
                          if (!_isPaused) {
                            _controllers[index].play();
                            _controllers[index].setLooping(true);
                          }
                        });
                      },
                    ),
                  ),

                  // Gradient overlay for text visibility
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPaused = !_isPaused;
                          if (_isPaused) {
                            _controllers[_currentCarouselIndex].pause();
                          } else {
                            _controllers[_currentCarouselIndex].play();
                          }
                        });
                      },
                      child: Center(
                        child: AnimatedOpacity(
                          opacity:
                              _isPaused ? 1.0 : 0.0, // Show only when paused
                          duration: Duration(milliseconds: 300),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isPaused ? Icons.play_arrow : Icons.pause,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Optional: Carousel indicators
                  // Positioned(
                  //   bottom: 10,
                  //   left: 0,
                  //   right: 0,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: videoFiles.asMap().entries.map((entry) {
                  //       return Container(
                  //         width: 8.0,
                  //         height: 8.0,
                  //         margin: EdgeInsets.symmetric(horizontal: 4.0),
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: _currentCarouselIndex == entry.key
                  //               ? Colors.white
                  //               : Colors.white.withOpacity(0.4),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                ],
              ),
            ),

            // Rest of your existing content...
            SizedBox(height: 20),
            Image.asset(
              'assets/decor/zzz_logo.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(137, 126, 126, 126),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome to the Zenless Zone Zero Wiki App',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Zenless Zone Zero is a free-to-play action RPG developed and published by HoYoverse. It was released for Windows, PlayStation 5, iOS, and Android on July 4th, 2024.\nThe game takes place in a post-apocalyptic futuristic metropolis known as New Eridu. Most of humanity has been wiped out by supernatural disasters called Hollows, which appear out of thin air creating disordered dimensions where monsters known as the Ethereals roam.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(137, 126, 126, 126),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Currently Featured Agents and W-Engines',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Image(
                    image: AssetImage('assets/decor/lighter_banner.png'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Image(
                    image: AssetImage('assets/decor/melody.png'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Image(
                    image: AssetImage('assets/decor/hugo_banner.png'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Image(
                    image: AssetImage('assets/decor/choir.png'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Time Remaining',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '9 day(s) 12 hour(s) 30 minute(s)',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Current Patch:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '1.7',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Continue with your existing code...
          ],
        ),
      ),
    );
  }

  // Your existing _buildFeatureButton method...
}
