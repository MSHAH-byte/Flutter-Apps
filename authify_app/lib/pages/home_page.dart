import 'package:authify_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../utils/animations/login_page_animations.dart';
import '../utils/animations/page_routes/slide_page_route.dart';

class AnimatedHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimatedHomePageState();
  }
}

class _AnimatedHomePageState extends State<AnimatedHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _HomePage(_controller!);
  }
}

class _HomePage extends StatelessWidget {
  double _deviceHeight = 0, _deviceWidth = 0;

  Color _primaryColor = Color.fromRGBO(169, 224, 241, 1.0);

  final AnimationController _controller;
  late final EnterAnimations _animation;

  _HomePage(this._controller) {
    _animation = EnterAnimations(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: _deviceHeight * 0.60,
          width: _deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _avatarWidget(),
              SizedBox(height: _deviceHeight * 0.03),
              _textWidget(),
              SizedBox(height: _deviceHeight * 0.1),
              _logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarWidget() {
    double _circleD = _deviceHeight * 0.25;
    return AnimatedBuilder(
      animation: _animation.controller,
      builder: (BuildContext _context, Widget? _widget) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            _animation.circleSize.value,
            _animation.circleSize.value,
            1,
          ),
          child: Container(
            height: _circleD,
            width: _circleD,
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(500),
              image: DecorationImage(
                image: AssetImage('assets/images/main_avatar.png'),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _textWidget() {
    return Container(
      child: Text(
        "JOHN DOE",
        style: TextStyle(
          color: _primaryColor,
          fontSize: 35,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _logoutButton(BuildContext _context) {
    return MaterialButton(
      minWidth: _deviceWidth * 0.33,
      height: _deviceHeight * 0.055,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(color: _primaryColor, width: 1.5),
      ),
      child: Text(
        "LOG OUT",
        style: TextStyle(
          fontSize: 16,
          color: _primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),

      onPressed: () {
        Navigator.push(_context, SlidePageRoute(AnimatedLoginPage()));
      },
    );
  }
}
