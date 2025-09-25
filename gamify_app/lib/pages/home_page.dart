import 'package:flutter/material.dart';
import '../data.dart';
import '../widgets/scrollable_games_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  int _selectedGame = 0;
  @override
  void initState() {
    super.initState();
    _selectedGame = 0;
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _featuredGamesWidget(),
          _gradientBoxWidget(),
          _topLayerWidget(),
        ],
      ),
    );
  }

  Widget _featuredGamesWidget() {
    return SizedBox(
      height: _deviceHeight * 0.50,
      width: _deviceWidth,
      child: PageView(
        onPageChanged: (_index) {
          setState(() {
            _selectedGame = _index;
          });
        },
        scrollDirection: Axis.horizontal,
        children: featuredGames.map((_game) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8), // optional spacing
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(_game.coverImage.url), //  use current game
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _gradientBoxWidget() {
    return IgnorePointer(
      // ADD THIS
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: _deviceHeight * 0.80,
          width: _deviceWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromRGBO(35, 45, 59, 1.0), Colors.transparent],
              stops: [0.65, 1.0],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }

  Widget _topLayerWidget() {
    return IgnorePointer(
      ignoring: false, // allows swipe through
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.05,
          vertical: _deviceHeight * 0.005,
        ),
        child: Column(
          children: <Widget>[
            _topBarWidget(),
            SizedBox(height: _deviceHeight * 0.13),
            if (featuredGames.isNotEmpty) _featureGamesInfoWidget(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01),
              child: ScrollableGamesWidget(
                _deviceHeight * 0.24,
                _deviceWidth,
                true,
                games,
              ),
            ),
            _featuredGameBannerWidget(),
            SizedBox(height: _deviceHeight * 0.013),
            ScrollableGamesWidget(
              _deviceHeight * 0.20,
              _deviceWidth,
              false,
              games2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBarWidget() {
    return SizedBox(
      height: _deviceHeight * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.menu, color: Colors.white, size: 30),
          Row(
            children: <Widget>[
              Icon(Icons.search, color: Colors.white, size: 30),
              SizedBox(width: _deviceWidth * 0.03),
              Icon(Icons.notifications_none, color: Colors.white, size: 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _featureGamesInfoWidget() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            featuredGames[_selectedGame].title,
            maxLines: 2,
            style: TextStyle(
              color: Colors.white,
              fontSize: _deviceHeight * 0.040,
            ),
          ),
          SizedBox(height: _deviceHeight * 0.01),
          Row(
            children: featuredGames.map((_games) {
              bool _isActive =
                  _games.title == featuredGames[_selectedGame].title;
              double _circularRadius = _deviceHeight * 0.004;
              return Container(
                margin: EdgeInsets.only(
                  right: _deviceWidth * 0.015,
                ), // add spacing
                height: _circularRadius * 2,
                width: _circularRadius * 2,
                decoration: BoxDecoration(
                  color: _isActive ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _featuredGameBannerWidget() {
    return Container(
      height: _deviceHeight * 0.13,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(featuredGames[3].coverImage.url),
        ),
      ),
    );
  }
}
