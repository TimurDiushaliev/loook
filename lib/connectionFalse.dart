import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loook/main.dart';

class ConnectionFailedPage extends StatelessWidget {
  const ConnectionFailedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    // final _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[400],
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: _height*0.05),
                  height: _height*0.2,
                  child: SvgPicture.asset('images/no_connection.svg')),
                Container(
                  margin: EdgeInsets.only(bottom: _height*0.05),
                  child: Text('Отсутсвует интернет подключение')),
                Container(
                    // margin: EdgeInsets.only(top: _height * 0.05),
                    child: RaisedButton(
                      child: Text('Повторить'),
                      color: Colors.purple[400],
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebViewPage()));
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
