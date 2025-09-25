import 'package:authify_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import '../utils/animations/login_page_animations.dart';
import '../utils/animations/page_routes/fade_page_routes.dart';

class AnimatedLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimatedLoginPageState();
  }
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage>
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
    return _LoginPage(_controller!);
  }
}

class _LoginPage extends StatelessWidget {
  double _deviceHeight = 0, _deviceWidth = 0;

  final Color _primaryColor = Color.fromRGBO(125, 191, 211, 1.0);
  final Color _secondryColor = Color.fromRGBO(169, 224, 241, 1.0);

  final AnimationController controller;
  late final EnterAnimations _animation;

  _LoginPage(this.controller) {
    _animation = EnterAnimations(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _primaryColor,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: _deviceWidth * 0.60,
          height: _deviceHeight * 0.70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              _avatarWidget(),
              SizedBox(height: _deviceHeight * 0.05),
              _emailTextField(),
              _passwordTextField(),
              SizedBox(height: _deviceHeight * 0.10),
              _loginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarWidget() {
    double _circleD = _deviceHeight * 0.25;
    return AnimatedBuilder(
      animation: _animation.circleSize,
      builder: (context, child) {
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
              color: _secondryColor,
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

  Widget _emailTextField() {
    return Container(
      width: _deviceWidth * 0.70,
      child: TextField(
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "John.Doe@gmai.com",
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return Container(
      width: _deviceWidth * 0.70,
      child: TextField(
        obscureText: true,
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext _context) {
    return MaterialButton(
      minWidth: _deviceWidth * 0.33,
      height: _deviceHeight * 0.055,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(color: Colors.white),
      ),
      child: Text(
        "LOG IN",
        style: TextStyle(
          fontSize: 16,
          color: _primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),

      onPressed: () async {
        await controller.reverse();
        Navigator.pushReplacement(_context, FadePageRoute(AnimatedHomePage()));
      },
    );
  }
}
