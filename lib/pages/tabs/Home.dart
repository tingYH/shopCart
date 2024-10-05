import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shopCart/config/Config.dart';

//轮播图类模型
import 'package:shopCart/model/FocusModel.dart';
import 'package:shopCart/model/ProductModel.dart';
import 'package:shopCart/services/ScreenAdapter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _focusData = [];
  List _hotProductData = [];
  List _hotProductStrData = [];

  @override
  void initState() {
    super.initState();
    // var strData='{"_id":"59f6ef443ce1fb0fb02c7a43","title":"笔记本电脑 ","status":"1","url":"12"}';
    //
    // var data = FocusModel.fromJson(json.decode(strData));
    _getFocusData();
    _getHotProductData();
  }

  _getFocusData() async {
    var api = Config.domain + 'api/focus';
    final response = await Dio().get(api);
    print(response.data is Map);
    var result = FocusModel.fromJson(response.data);

    result.result?.forEach((element) {
      _focusData.add(element.pic?.replaceAll("\\", "/"));
    });
    setState(() {
      _focusData;
    });
  }

  //获取猜你禧欢数据
  _getHotProductData() async {
    var api = Config.domain + 'api/plist?is_hot=1';
    final response = await Dio().get(api);
    print(response.data is Map);
    var hotProdcutList = ProductModel.fromJson(response.data);

    hotProdcutList.result?.forEach((element) {
      _hotProductData.add(element.pic?.replaceAll("\\", "/"));
      _hotProductStrData.add(element.price);
    });
    setState(() {
      _hotProductData;
      _hotProductStrData;
    });
  }

  //轮播图
  Widget _swiperWidget() {
    if (_focusData.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String url = "${Config.domain}${this._focusData[index]}";
              return Image.network(
                url,
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
    if (this._hotProductData.length > 0) {
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
                    Config.domain + _hotProductData[index],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                  height: ScreenAdapter.height(44),
                  child: Text(
                    "NT "+_hotProductStrData[index].toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
          itemCount: _hotProductData.length,
        ),
      );
    } else {
      return Text('加载中');
    }
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
