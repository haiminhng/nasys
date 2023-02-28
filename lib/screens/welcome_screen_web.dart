import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreenWeb extends StatefulWidget {
  const WelcomeScreenWeb({Key? key}) : super(key: key);

  @override
  _WelcomeScreenWebState createState() => _WelcomeScreenWebState();
}

class _WelcomeScreenWebState extends State<WelcomeScreenWeb>
    with SingleTickerProviderStateMixin {
  static const double kOpacityValue = 0.5;
  static const Duration kAnimationDuration = Duration(milliseconds: 500);

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  bool _isFirstImageHovered = false;
  bool _isSecondImageHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: kAnimationDuration,
      reverseDuration: kAnimationDuration,
    );
    _opacityAnimation =
        Tween<double>(begin: kOpacityValue, end: 1.0).animate(_controller);

    // Start the animation when the widget is first built
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onFirstImageHover(bool isHovering) {
    setState(() {
      _isFirstImageHovered = isHovering;
    });

    if (isHovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _onSecondImageHover(bool isHovering) {
    setState(() {
      _isSecondImageHovered = isHovering;
    });

    if (isHovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MouseRegion(
              onEnter: (_) => _onFirstImageHover(true),
              onExit: (_) => _onFirstImageHover(false),
              child: GestureDetector(
                child: AnimatedOpacity(
                  opacity: _isFirstImageHovered ? 1.0 : kOpacityValue,
                  duration: kAnimationDuration,
                  child: Image.asset(
                    'assets/logo/minh_digital_banner_dark.png',
                    width: 400,
                    height: 400,
                    color: Colors.white.withOpacity(kOpacityValue),
                  ),
                ),
                onTap: () {
                  _launchURL('https://minh.digital');
                },
              ),
            ),
            const SizedBox(width: 50),
            MouseRegion(
              onEnter: (_) => _onSecondImageHover(true),
              onExit: (_) => _onSecondImageHover(false),
              child: GestureDetector(
                child: AnimatedOpacity(
                  opacity: _isSecondImageHovered ? 1.0 : kOpacityValue,
                  duration: kAnimationDuration,
                  child: Image.asset(
                    'assets/logo/nasys_banner_dark.png',
                    width: 400,
                    height: 400,
                    color: Colors.white.withOpacity(kOpacityValue),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
