import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/components/loading.dart';

import 'image-reviewer.dart';
import 'package:graduation_project/models/user-story.dart';
import 'package:graduation_project/api/story-sql-api.dart';
import 'package:graduation_project/models/story-image.dart';
import 'package:graduation_project/services/sql_lite/story_functions.dart';
class StoryGridView extends StatefulWidget {
  UserStory story;
  StoryGridView(this.story);

  @override
  _StoryGridViewState createState() => _StoryGridViewState();
}

class _StoryGridViewState extends State<StoryGridView> {

  bool editingStoryName = false;
  bool doneEditingStory=false;
  String storyName='';
  final textFieldController = TextEditingController(text: "");
  List<StoryImage> images=[];
  StorySQLApi storySQLApi=new StorySQLApi();
  bool changed=false;
  @override
  void initState() {
    super.initState();
    textFieldController.text=widget.story.name;
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
      resizeToAvoidBottomPadding:false,

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
                  editingStoryName
                      ? SizedBox(
                    width: 200,
                        child: TextFormField(
                          controller: textFieldController,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            decoration: new InputDecoration(
                                hintText: 'search...',
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            // onChanged: (text) {
                            //   text = text.toLowerCase();
                            //   setState(() {
                            //   });
                            // },
                          ),
                      )
                      : Container(
                          child: Text(textFieldController.text+"    ",
                              style: GoogleFonts.lobsterTwo(
                                  fontSize: 32, color: Colors.black)),
                        ),
                  IconButton(
                    icon: editingStoryName?Icon(Icons.done_outline,color: Colors.deepOrange,):
                    Icon(Icons.edit_outlined,color: Colors.black,),
                    onPressed: ()
                    {
                      toggleEditingStory();
                    },
                  ),
                ],
              )),
          Positioned.fill(
            top: -550,
            left: 270,
            child:FlatButton(
              onPressed: () {
                doneEditingStoryFun();
              },
              child: Text('Done Editing',
                style: TextStyle(color: Colors.deepOrange),),

            )
            ,
          ),

      FutureBuilder(
        key: ValueKey(changed) ,
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

  toggleEditingStory() {
    
    setState(() {
      storyName=textFieldController.text;
      editingStoryName=!editingStoryName;
    });

    print(storyName);
  }

  void doneEditingStoryFun() {
    changeNameOfStory();
    setState(() {
      doneEditingStory=true;

    });
    Navigator.pop(context,1);

  }

  void fetchStory(String id) async{
    storySQLApi.fetchImagesOfStory(id).then((value)
    {
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
                    onTap: ()async
                    {
                      int result=await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return ImageReview(image:list[index],);
                          })
                      );//print(index);
                      reloadImages(result);

                    },
                    child: FadeInImage.memoryNetwork(
                      image: list[index].path,
                      placeholder: kTransparentImage,
                      fit: BoxFit.cover,
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
       changed=true;
    });
  }

  void changeNameOfStory() {
    setState(() {
      storyName=textFieldController.text;

    });
    StoryFunctions.update(int.parse(widget.story.id),textFieldController.text);
    
  }

}

