import 'package:flutter/material.dart';
import '../data.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> locations = ['Poluare', 'Japan', 'Moscow', 'London'];
  int activeLocation = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: _mainColumn(context),
      ),
    );
  }

  Widget _mainColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu, color: Colors.black87, size: 35),
            Container(
              height: 39,
              width: 144,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/logo_discover.png'),
                ),
              ),
            ),
            Icon(Icons.search, color: Colors.black87, size: 35),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.03,
          ),
          child: _locationBar(),
        ),
        _articleList(context),
      ],
    );
  }

  Widget _locationBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromRGBO(69, 69, 69, 1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: locations.map((l) {
          bool isActive = locations[activeLocation] == l;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l,
                style: TextStyle(
                  fontSize: 15,
                  color: isActive ? Colors.white : Colors.white54,
                  fontFamily: 'Montserrat',
                ),
              ),
              if (isActive)
                Container(
                  margin: EdgeInsets.only(top: 3),
                  height: 5,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.redAccent,
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _articleList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: article.image.startsWith('http')
                            ? NetworkImage(article.image)
                            : AssetImage(article.image),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: _articleInfoColumn(context, index),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: MediaQuery.of(context).size.width * 0.15,
                child: _socialInfoContainer(context, index),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _articleInfoColumn(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 30, 0),
          child: _authorInfoRow(index),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            30,
            MediaQuery.of(context).size.height * 0.05,
            30,
            0,
          ),
          child: _detailInfoRow(context, index),
        ),
      ],
    );
  }

  Widget _authorInfoRow(int index) {
    final article = articles[index];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.author,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '3 hours ago',
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Icon(Icons.favorite, color: Colors.red, size: 20),
            SizedBox(height: 5),
            Icon(Icons.bookmark, color: Colors.white, size: 20),
          ],
        ),
      ],
    );
  }

  Widget _detailInfoRow(BuildContext context, int index) {
    final article = articles[index];

    return Row(
      children: [
        FloatingActionButton(
          heroTag: "play_$index", //  avoids FAB conflicts
          backgroundColor: Colors.white,
          child: Icon(Icons.play_arrow, color: Colors.redAccent, size: 30),
          onPressed: () {},
          shape: CircleBorder(),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.50,
              child: Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 3),
            Text(
              article.location,
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
            _ratingWidget(article.rating),
          ],
        ),
      ],
    );
  }

  Widget _socialInfoContainer(BuildContext context, int index) {
    final article = articles[index];

    return Container(
      height: MediaQuery.of(context).size.width * 0.07,
      width: MediaQuery.of(context).size.width * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.redAccent),
              SizedBox(width: 4),
              Text(
                article.likes.toString(),
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.mode_comment, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                article.comments.toString(),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.share, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                article.shares.toString(),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ratingWidget(double rating) {
    return Row(
      children: List.generate(5, (i) {
        if (rating >= i + 1) {
          return Icon(Icons.star, color: Colors.amberAccent, size: 15);
        } else if (rating > i && rating < i + 1) {
          return Icon(Icons.star_half, color: Colors.amberAccent, size: 15);
        } else {
          return Icon(Icons.star_border, color: Colors.amberAccent, size: 15);
        }
      }),
    );
  }
}
