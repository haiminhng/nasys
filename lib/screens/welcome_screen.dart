import 'package:flutter/material.dart';
import 'package:nasys/screens/login/login_screen.dart';
import 'package:nasys/theme/theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'Nails CheckIn System',
      'description': 'Access the Nails CheckIn System with the ease of your phone. Check in to your local salon, receive reward points, and manage your coupons all in one place.',
      'image': 'assets/images/welcome_screen/checkin_light.png',
    },
    {
      'title': 'Salon Management',
      'description': 'Streamline your administrative tasks and manage your branches, customer information, check-ins, staff, policies, and coupons across all locations using a single, comprehensive platform.',
      'image': 'assets/images/welcome_screen/management_light.png',
    },
    {
      'title': 'Customer Point Checking',
      'description': 'Easily check your reward points, redeem your rewards, and manage your coupons all from your phone. Receive notifications for special offers and promotions from your favorite nail salon.',
      'image': 'assets/images/welcome_screen/customer_care_light.png',
    },
  ];


  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeTransition(
                                  opacity: _opacityAnimation,
                                  child: Text(
                                    _slides[index]['title'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: AppTheme.getTextColor(context),
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                FadeTransition(
                                  opacity: _opacityAnimation,
                                  child: Text(
                                    _slides[index]['description'],
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: AppTheme.getTextColor(context),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(_slides[index]['image']),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 62),
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Get Started'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _slides.length; i++) {
      list.add(i == _currentPageIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 8,
      width: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Color(0xFFDDA0DD) : Colors.grey[300],
      ),
    );
  }
}
