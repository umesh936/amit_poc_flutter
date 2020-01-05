import 'package:amit_poc_flutter/model/product_model.dart';
import 'package:amit_poc_flutter/services/product_service.dart';
import 'package:flutter/material.dart';

import 'manufacturer_list_screen.dart';

class ItemScreen extends StatefulWidget {
  final String toolbarname;
  final String categoryId;

  ItemScreen({Key key, this.toolbarname,this.categoryId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => item(toolbarname,categoryId);
}



class item extends State<ItemScreen> {


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;
  final String categoryId;
  List<Product> products = new List();

  item(this.toolbarname, this.categoryId);

  @override
  void initState() {
    super.initState();
    loadProductForCategory(categoryId)
    .then((result) {
      setState(() {
        products = result.products;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData _backIcon() {
      switch (Theme
          .of(context)
          .platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
      }
      assert(false);
      return null;
    }

    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(_backIcon()),
          alignment: Alignment.centerLeft,
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(toolbarname),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                //childAspectRatio: (itemWidth / itemHeight),
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(3.0),
                children: products.map((Product photo) {
                  return TravelDestinationItem(
                    displayProduct: photo,
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TravelDestinationItem extends StatelessWidget {
  TravelDestinationItem({Key key, @required this.displayProduct, this.shape})
      : assert(displayProduct != null),
        super(key: key);

  static const double height = 200.0;
  final Product displayProduct;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return SafeArea(
        top: false,
        bottom: false,
        child: Container(
            padding: const EdgeInsets.all(2.0),
            height: height,
            child: GestureDetector(
              onTap: () {
              },
              child: Card(
                shape: shape,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // photo and title
                    SizedBox(
                      height: 70.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              displayProduct.imagePath,
                              // package: destination.assetPackage,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            // padding: EdgeInsets.all(5.0),
                            child: IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {}),
                          ),
                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    Divider(),
                    SizedBox(
                      height: 80.0,
                      child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 0.0),
                        child: DefaultTextStyle(
                          style: descriptionStyle,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  displayProduct.name,
                                  style: descriptionStyle.copyWith(
                                      color: Colors.black87),
                                ),
                              OutlineButton(
                                  borderSide: BorderSide(color: Colors.amber.shade500),
                                  child: Text( "Manufacture "+displayProduct.manufactureCount),
                                  textColor: Colors.amber.shade500,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  ManufacturerListPage(
                                              title:'Manufacturer'
                                            )));

                                  },
                                  shape: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // share, explore buttons
                  ],
                ),
              ),
            )));
  }

}
