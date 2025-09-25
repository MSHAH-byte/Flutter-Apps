import 'package:flutter/material.dart';
import '../data.dart';

class ScrollableGamesWidget extends StatelessWidget {
  late final double _height, _width;
  late final bool _showTile;
  late final List<Game> _gamesData;

  ScrollableGamesWidget(
    this._height,
    this._width,
    this._showTile,
    this._gamesData,
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: _gamesData.map((_games) {
          return Container(
            height: _height * 0.7,
            width: _width * 0.3,
            padding: EdgeInsets.only(right: _width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: _height * 0.7,
                  width: _width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_games.coverImage.url),
                    ),
                  ),
                ),
                _showTile
                    ? Text(
                        _games.title,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _height * 0.08,
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
