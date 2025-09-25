import 'package:flutter/material.dart'
    show
        Align,
        Alignment,
        AssetImage,
        BorderRadius,
        BoxDecoration,
        BoxFit,
        BuildContext,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        DecorationImage,
        EdgeInsets,
        FontWeight,
        Key,
        MainAxisAlignment,
        MainAxisSize,
        MaterialButton,
        MediaQuery,
        Row,
        SafeArea,
        Scaffold,
        Stack,
        StatelessWidget,
        Text,
        TextStyle,
        Widget;
import 'package:go_moon/widgets/custom_dropdown_button.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final double _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: _deviceHeight,
          width: _deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _pageTitle(),
                  _bookRideWidget(_deviceHeight, _deviceWidth),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _astroImageWidget(_deviceHeight, _deviceWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return const Text(
      "#GoMoon",
      style: TextStyle(
        color: Colors.white,
        fontSize: 70,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _astroImageWidget(double _deviceHeight, double _deviceWidth) {
    return Container(
      height: _deviceHeight * 0.50,
      width: _deviceWidth * 0.65,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/astro_moon.png"),
        ),
      ),
    );
  }

  Widget _bookRideWidget(double _deviceHeight, double _deviceWidth) {
    return Container(
      height: _deviceHeight * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _destinationDropDownWidget(_deviceWidth),
          _travellersInformationWidget(_deviceWidth),
          _rideButton(_deviceHeight, _deviceWidth),
        ],
      ),
    );
  }

  Widget _destinationDropDownWidget(double _deviceWidth) {
    return CustomDropdownButtonClass(
      values: ['james webb station', 'preneure station'],
      width: _deviceWidth,
    );
  }

  Widget _travellersInformationWidget(double _deviceWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomDropdownButtonClass(
          values: ['1', '2', '3', '4'],
          width: _deviceWidth * 0.39,
        ),
        CustomDropdownButtonClass(
          values: ['Economy', 'Business', 'First', 'Private'],
          width: _deviceWidth * 0.39,
        ),
      ],
    );
  }

  Widget _rideButton(double _deviceHeight, double _deviceWidth) {
    return Container(
      margin: EdgeInsets.only(bottom: _deviceHeight * 0.001),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: _deviceWidth,
      child: MaterialButton(
        onPressed: () {},
        child: const Text("Book Ride!", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
