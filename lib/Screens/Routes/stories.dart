import 'package:flutter/material.dart';
import 'package:graduation_project/models/user-story.dart';
import 'package:toast/toast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'card.dart';
import 'package:graduation_project/models/story-image.dart';

import 'routeMap.dart';
class MyRoutes extends StatefulWidget {
  List<UserStory> stories;

  MyRoutes(this.stories);

  @override
  _MyRoutesState createState() => _MyRoutesState();
}

class _MyRoutesState extends State<MyRoutes> {
  bool deleted = false;
  final _myListKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    // showStories();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.stories.length == 0
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "No stories for now",
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
            return _buildItem( widget.stories[index],index);

            //  return _buildItem(index);
          }),
    );
  }

  void showStories() {
    // print(widget.stories[0].storyImages);
  }

  void deleteStory(int index) {
   // StoryFunctions.delete(int.parse(widget.stories[index].id));
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
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            deleted = showDeleteDialog(context, story, index);
          },
        ),
      ],
    );
  }


}
