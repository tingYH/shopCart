import 'package:flutter/material.dart';
import 'package:shopCart/services/ScreenAdapter.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    //注意用ScreenAdaper必须得在build方法里面初始化
    ScreenAdapter.init(context);

    //计算右侧GridView宽高比

    //左侧宽度

    var leftWidth= ScreenAdapter.getScreenWidth()/4;

    //右侧每一项宽度=（总宽度-左侧宽度-GridView外侧元素左右的Padding值-GridView中间的间距）/3

    var rightItemWidth=(ScreenAdapter.getScreenWidth()-leftWidth-20-20)/3;

    //获取计算后的宽度
    rightItemWidth=ScreenAdapter.width(rightItemWidth);
    //获取计算后的高度
    var rightItemHeight=rightItemWidth+ScreenAdapter.height(28);
    return Row(
      children: <Widget>[
        Container(
          width: leftWidth,
          height: double.infinity,
          color: Colors.white,
          child: ListView.builder(
            itemCount: 28,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = index;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: ScreenAdapter.height(56),
                      child: Text(
                        "第${index}個",
                        textAlign: TextAlign.center,
                      ),
                      color: _selectIndex == index ? Colors.red : Colors.white,
                    ),
                  ),
                  Divider()
                ],
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding:EdgeInsets.all(10),
              height: double.infinity,
              color: Color.fromRGBO(240, 246, 246, 0.9),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: rightItemWidth /rightItemHeight,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: 18,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          AspectRatio(aspectRatio: 1/1,child: Image.network("https://www.itying.com/images/flutter/list8.jpg",  fit:BoxFit.cover),
                          ),
                          Container(
                            height: ScreenAdapter.height(28),
                            child: Text("女裝"),
                          )
                        ],
                      ),
                    );
                  })),
        )
      ],
    );
  }
}
