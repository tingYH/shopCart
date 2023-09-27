import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';

//轮播图类模型
import 'package:shopCart/model/FocusModel.dart';
import 'package:shopCart/services/ScreenAdapter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _focusData = [];

  @override
  void initState() {
    super.initState();
    // var strData='{"_id":"59f6ef443ce1fb0fb02c7a43","title":"笔记本电脑 ","status":"1","url":"12"}';
    //
    // var data = FocusModel.fromJson(json.decode(strData));
    _getFocusData();
  }


  _getFocusData() async {
    var api = 'https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1';
    final response = await Dio().get(api);
    print(response.data is Map);
    var result = FocusModel.fromJson(response.data);

    print(result);
    result.images?.forEach((element) {
      print(element.title);
      print(element.url);
      print(element.copyrightlink);
      _focusData.add(element.url);
    });
    setState(() {
      _focusData;
    });
  }

  //轮播图
  Widget _swiperWidget() {
    if (_focusData.length > 0) {
      // List<Map> imgList = [
      //   {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      //   {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      //   {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
      // ];
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
               "https://cn.bing.com/${this._focusData[index]}" ,
                fit: BoxFit.fill,
              );
            },
            itemCount: this._focusData.length,
            pagination: new SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Text('加载中');
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdapter.height(32),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.red,
            width: ScreenAdapter.width(10),
          ),
        ),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }

  //热门商品
  Widget _hotProductListWidget() {
    return Container(
      height: ScreenAdapter.height(230),
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                height: ScreenAdapter.height(140),
                width: ScreenAdapter.width(140),
                margin: EdgeInsets.only(right: ScreenAdapter.width(10)),
                child: Image.network(
                  "https://www.itying.com/images/flutter/hot${index + 1}.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                height: ScreenAdapter.height(44),
                child: Text("第$index条"),
              )
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }

  //推荐商品
  _recProductItemWidget() {
    var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      width: itemWidth,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1),
      ),
      child: Column(children: <Widget>[
        Container(
          width: double.infinity,
          child: AspectRatio(
            //防止服务器返回的图片大小不一致导致高度不一致问题
            aspectRatio: 1 / 1,
            child: Image.network(
              "https://www.itying.com/images/flutter/list1.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
          child: Text(
            "asdsadasdasdsadsad2222222222222222sadasdasd",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black54),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
          child: Stack(
            children: <Widget>[
              Align(
                child: Text(
                  "NT 123",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                alignment: Alignment.centerLeft,
              ),
              Align(
                child: Text(
                  "NT 500",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough),
                ),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(
          height: ScreenAdapter.height(20),
        ),
        _titleWidget("猜你喜欢"),
        SizedBox(
          height: ScreenAdapter.height(20),
        ),
        _hotProductListWidget(),
        _titleWidget("热门推荐"),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: <Widget>[
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
