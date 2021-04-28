import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Routes/card.dart';
import 'package:graduation_project/Screens/bookmarks/date_divider.dart';
import 'package:graduation_project/models/story-image.dart';
import 'package:toast/toast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:graduation_project/gist.dart';
import 'routeMap.dart';
import 'package:graduation_project/models/user-story.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/services/sql_lite/story_functions.dart';
import 'package:graduation_project/services/sql_lite/image_functions.dart';
import 'package:graduation_project/services/sql_lite/point_functions.dart';
import 'dart:convert';
import 'package:graduation_project/api/story-sql-api.dart';
import 'package:graduation_project/api/xampp_util.dart';

class Stories extends StatelessWidget {
  StorySQLApi storySQLApi = new StorySQLApi();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            "My Routes",
            style: TextStyle(color: Colors.black87),
          ),
          bottom: TabBar(
            indicatorWeight: 1,
            indicatorColor: Colors.grey,
            unselectedLabelColor: Colors.grey,
            labelColor:Colors.deepOrange ,
            tabs: [
              Tab( child: Text("not synced",style: TextStyle(fontSize: 18,),),),
              Tab( child: Text(" synced",style: TextStyle(fontSize: 18,),),)
            ],
          ),
        ),
        body: TabBarView(
          children:
          [
            FutureBuilder(
                future: storySQLApi.fetchAllStories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return Loading();
                      break;
                    case ConnectionState.waiting:
                      return Loading();
                      break;
                    case ConnectionState.none:
                      return Error(errorText: 'No Internet Connection');
                      break;
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Error(errorText: snapshot.error.toString());
                        break;
                      } else if (snapshot.hasData) {
                        {
                          // print(snapshot.data);
                          return MyRoutes(snapshot.data);
                        }
                      }
                  }
                  return Container(
                    color: Colors.white,
                  );
                }),
            Text("hii")
          ]
        ),
      ),
    );
  }
}

class MyRoutes extends StatefulWidget {
  List<UserStory> stories;

  MyRoutes(this.stories);

  @override
  _MyRoutesState createState() => _MyRoutesState();
}

class _MyRoutesState extends State<MyRoutes> {
  bool deleted = false;
  StorySQLApi storySQLApi = new StorySQLApi();
  final _myListKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    // showStories();
  }

  @override
  Widget build(BuildContext context) {
    String f = "";
    String f1 = "";
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.stories.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "No stories to sync",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            )
          : AnimatedList(
              key: _myListKey,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 20),
              initialItemCount: widget.stories.length,
              itemBuilder: (context, index, animation) {
                return FutureBuilder(
                    future: storySQLApi.fetchAllStories(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                          return Container();
                          break;
                        case ConnectionState.waiting:
                          return Container();
                          break;
                        case ConnectionState.none:
                          return Error(errorText: 'No Internet Connection');
                          break;
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(errorText: snapshot.error.toString());
                            break;
                          } else if (snapshot.hasData) {
                            {
                              if(snapshot.data[index].synced!='true')
                              return _buildItem(snapshot.data[index], index);
                            }
                          }
                      }
                      return Container(
                        color: Colors.white,
                      );
                    });
                //  return _buildItem(index);
              }),
    );
  }

  void showStories() {
    // print(widget.stories[0].storyImages);
  }

  void deleteStory(int index) {
    StoryFunctions.delete(int.parse(widget.stories[index].id));
  }

  bool showDeleteDialog(BuildContext context, UserStory story, index) {
    bool deletingDone = false;
    //print(index.toString()+"index");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: new Text(
                "are sure you want to delete ${widget.stories[index].name}?"),
            content: new Text("you can confirm by pressing ok"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  deletingDone = true;
                  deleteStory(index);
                  Toast.show("route has been deleted", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

                  Navigator.pop(context);
                  reflectDeleting(story, index);
                },
              ),
            ],
          );
        });
    return deletingDone;
  }

  bool showSyncDialog(BuildContext context, UserStory story, index) {
    bool deletingDone = false;
    //print(index.toString()+"index");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: new Text(
                "are sure you want to sync ${widget.stories[index].name}?"),
            content: new Text("syncing this story will prevent you to modify it later"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: ()async {
                  Navigator.pop(context);

                  deletingDone = true;
                 syncFunction(story,index);
                  Toast.show("route has been deleted", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

                  reflectDeleting(story, index);
                },
              ),
            ],
          );
        });
    return deletingDone;
  }


  void reflectDeleting(UserStory story, int index) {
    setState(() {
      widget.stories.removeAt(index);
    });
    _myListKey.currentState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        return FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
          child: SizeTransition(
            sizeFactor:
                CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
            axisAlignment: 0.0,
            child: _buildItem(story, index),
          ),
        );
      },
      duration: Duration(milliseconds: 600),
    );
  }

  Widget _buildItem(UserStory story, int index) {
    return Slidable(
      key: ValueKey(index),
      //controller: slidableController,
      child: RouteCard(
        story: story,
        isOpend: false,
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconButton(
          iconSize: 40,
          color: Colors.deepOrangeAccent,
          icon: Icon(Icons.location_on_outlined),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RouteMap(
                pathPoints: story.userPath,
              );
            })); //print(index);
          },
        ),
        IconButton(
          iconSize: 40,
          color: Colors.deepOrangeAccent,
          icon: Icon(Icons.upload_outlined),
          onPressed: () {
            bool sync=showSyncDialog(context, story, index);
            },
        ),
        IconButton(
          iconSize: 40,
          color: Colors.deepOrangeAccent,
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            deleted = showDeleteDialog(context, story, index);
          },
        ),
      ],
    );
  }

  void syncFunction(UserStory story,int index)  {
    bool sync=showSyncDialog(context, story, index);

     StoryFunctions.updateSync(int.parse(story.id), 'true');

    for (var item in story.storyImages) {
       uploadImageToServer(item);
    }
  }

  Future<int> uploadImageToServer(StoryImage image) async {
    String serverFileName = '';
    serverFileName = image.id.toString() +
        DateTime.now().microsecondsSinceEpoch.toString() +
        '.jpg';
    int result = await XamppUtilAPI.UPLOAD_IMAGE(serverFileName, image.path);
    if (result == 1) {
      modifyImagePath(image, serverFileName);
    }
    return result;
  }

  void modifyImagePath(StoryImage image, String serverFileName) async {

    serverFileName = 'http://10.0.2.2:80/story_images/' + serverFileName;
    int result =
        await ImageFunctions.updatePath(int.parse(image.id), serverFileName);
    //print(ImageFunctions.queryRow(image.id).toString());
  }
}
