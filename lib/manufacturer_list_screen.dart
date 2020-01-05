import 'package:amit_poc_flutter/model/manufacturer_model.dart';
import 'package:amit_poc_flutter/services/manufacture_service.dart';
import 'package:flutter/material.dart';

class ManufacturerListPage extends StatefulWidget {
  ManufacturerListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ManufacturerListPage> {
  ManufacturerList allManufacturer;

  @override
  void initState() {
    super.initState();
    loadManufacture().then((result) {
      setState(() {
        allManufacturer = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Manufacturer manufacturer) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.account_circle, color: Colors.white, size: 60),
          ),
          title: Text(
            manufacturer.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Text(manufacturer.locationName,
                          style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Text(
                          manufacturer.underPromotion ? 'Recomended' : '',
                          style: TextStyle(color: Colors.yellowAccent)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < manufacturer.rating
                              ? Icons.star
                              : Icons.star_border,
                          size: 20,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            // Implement Detail Page
          },
        );

    Card makeCard(Manufacturer manufacturer) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.blueGrey, Colors.white],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: makeListTile(manufacturer),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: allManufacturer.manufacturerList == null
            ? 0
            : allManufacturer.manufacturerList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(allManufacturer.manufacturerList[index]);
        },
      ),
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      appBar: topAppBar,
      body: makeBody,
    );
  }
}
