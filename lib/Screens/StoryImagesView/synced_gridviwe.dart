import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/components/loading.dart';
import 'dart:convert';
import 'package:image_fade/image_fade.dart';
import 'synced_reviewer.dart';
import 'package:graduation_project/models/user-story.dart';
import 'package:graduation_project/api/story-sql-api.dart';
import 'package:graduation_project/models/story-image.dart';
import 'package:graduation_project/services/sql_lite/story_functions.dart';

class SyncedGridview extends StatefulWidget {
  UserStory story;

  SyncedGridview(this.story);

  @override
  _StoryGridViewState createState() => _StoryGridViewState();
}

class _StoryGridViewState extends State<SyncedGridview> {
  final textFieldController = TextEditingController(text: "");
  List<StoryImage> images = [];
  StorySQLApi storySQLApi = new StorySQLApi();
  bool changed = false;

  @override
  void initState() {
    super.initState();
    textFieldController.text = widget.story.name;
    // fetchStory(widget.story.id);
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          Positioned(
            top: 30,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 27,
                  color: Colors.deepOrange,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          Positioned.fill(
              top: -500,
              left: 40,
              child: Row(
                children: [
                  Container(
                    child: Text(textFieldController.text+"    ",
                        style: GoogleFonts.lobsterTwo(
                            fontSize: 32, color: Colors.black)),
                  ),
                ],
              )),
          FutureBuilder(
              key: ValueKey(changed),
              future: storySQLApi.fetchImagesOfStory(widget.story.id),
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
                        print(snapshot.data);
                        return imagesWidget(snapshot.data);
                      }
                    }
                }
                return Container(
                  color: Colors.white,
                );
              }),
        ],
      ),
    );
  }


  void fetchStory(String id) async {
    storySQLApi.fetchImagesOfStory(id).then((value) {
      setState(() {
        images.addAll(value);
      });
    });
  }

  Widget imagesWidget(var list) {
    return Positioned.fill(
      top: 97,
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 12, top: 12),
        child: new StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: InkWell(
                    onTap: () async {
                      int result = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ImageReview(
                          image: list[index],
                        );
                      })); //print(index);
                      reloadImages(result);
                    },
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      fit: BoxFit.cover,
                      image: list[index].path,
                    ),

                  ),
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
            }),
      ),
    );
  }

  void reloadImages(int result) {
    //print (result);
    setState(() {
      changed = true;
    });
  }

}
