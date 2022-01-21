import 'package:flutter/material.dart';
import '../home/ListFavorite.dart';
import 'package:travel_app/providers/FunctionsModel.dart';
import '../models/HotDestinaltion.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  List<HotDestinations> hotDestinations = [];
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => listFavorits(
                    )));
                  },
                  icon: Icon(
                    Icons.favorite_border_rounded,
                    size: 40,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 10,
                  child: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    //display total items added
                    child: Text(
                      '${context.watch<FunctionsModel>().count}',
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      //items display
      body: GridView.count(
        childAspectRatio: 0.75,
        crossAxisCount: 2,
        children: List.generate(hotDestinations.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              child: Column(
                children: <Widget>[
                  Stack(children: [
                    Image.asset(
                      hotDestinations[index].image,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Add to favorits'),
                        //comsumer here to trigger actions when button pressed
                        Consumer<FunctionsModel>(
                            builder: (context, FunctionsModel, child) {
                          return IconButton(
                            icon: Icon(Icons.favorite_border_outlined),
                            onPressed: () {
                              setState(() {
                                FunctionsModel.addCountry(
                                    hotDestinations[index]);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      '${hotDestinations[index].placeName} added to favorits'),
                                ));
                              });
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 20,
                    top: 20,
                    child: Text(
                      hotDestinations[index].placeName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
