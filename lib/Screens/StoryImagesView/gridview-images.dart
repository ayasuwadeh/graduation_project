import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'image-reviewer.dart';
import 'package:graduation_project/models/story-image.dart';
class StoryGridView extends StatefulWidget {
  final List<StoryImage> images;

  const StoryGridView({Key key, this.images}) : super(key: key);
  @override
  _StoryGridViewState createState() => _StoryGridViewState();
}

class _StoryGridViewState extends State<StoryGridView> {
  // List<String> imageList = [
  //   //'http://10.0.2.2:80/story_images/CAP1200635995888124012.jpg',
  //   'https://www.outlookindia.com/outlooktraveller/resizer.php?src=https://www.outlookindia.com/outlooktraveller/public/uploads/articles/explore/shutterstock_777102832_(1).jpg&w=500&h=400',
  //   'https://www.outlookindia.com/outlooktraveller/resizer.php?src=https://www.outlookindia.com/outlooktraveller/public/uploads/articles/explore/shutterstock_777102832_(1).jpg&w=500&h=400',
  //   'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80',
  //   'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80',
  //   'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80',
  //   'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80',
  // ];

  bool editingStoryName = false;
  String storyName='';
   final textFieldController = TextEditingController(text: "paris vibes");

  @override
  void initState() {
    super.initState();
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
                    width: 250,
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
                            onChanged: (text) {
                              text = text.toLowerCase();
                              setState(() {
                              });
                            },
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
                  )
                ],
              )),
          Positioned.fill(
            top: 97,
            child: Container(
              margin: EdgeInsets.only(left: 12, right: 12, top: 12),
              child: new StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: InkWell(
                          onTap: ()
                          {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return ImageReview(image:widget.images[index],);
                                }));//print(index);
                          },
                          child: FadeInImage.memoryNetwork(
                            image: widget.images[index].path,
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
          ),
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

}
