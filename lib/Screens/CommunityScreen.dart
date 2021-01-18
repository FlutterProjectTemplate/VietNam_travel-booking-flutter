import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/Models/Post.dart';
import 'package:mobile/Network/Api.dart';
import 'package:mobile/Screens/CommentScreen.dart';
import 'package:mobile/Screens/LoginScreen.dart';
import 'package:mobile/Screens/SearchScreen.dart';
import 'package:mobile/globals.dart' as globals;
import 'PostScreen.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<Post> posts;
  @override
  void initState() {
    super.initState();
    Api.getPosts().then((value) {
      setState(() {
        posts=value;
      });
    });
  }
  static List getDummyList(int length) {
    List list = List.generate(length, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }
  @override
  Widget build(BuildContext context) {
    List items = getDummyList(posts==null? 0 : posts.length);
    if(globals.isLoggedIn==false){
      return Center(
        child: Text("Vui lòng đăng nhập để sử dụng tính năng này",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(22.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Địa điểm muốn khám phá",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchScreen(),
                          ),
                        );
                      },
                    )),
                Expanded(
                    flex: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ))
              ],
            )),
        backgroundColor: Colors.orange,
      ),
      body:
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(20),
        //   color: Colors.white,
        // ),
        Column(children: <Widget>[
          SafeArea(
            child: PostMenu(),
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 200.0,
                      child:  ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) =>
                              CardPost(context,index),
                       ),

                    ),
                  ),
                ]),
          ),
]),
    );
  }
  Widget CardPost(BuildContext context, int index) {
    final Post post = posts[index];
    DateTime date;
    String formattedDate;
    if(post!=null) {
      date=DateTime.parse(post.time);
      formattedDate = "Lúc ${date.hour.toString()}:${date.minute.toString()} ngày ${date.day.toString().padLeft(2,'0')}-${date.month.toString().padLeft(2,'0')}-${date.year.toString()} ";
    } else formattedDate="0";
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 500.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(

          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 50.0,
                            width: 50.0,
                            image: NetworkImage(post==null? 'Loading...' : post.imageEntities[0].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      "${ post==null ? 'Loading...' : post.nameUser}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("${formattedDate}"),
                    trailing: IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.black,
                      onPressed: () => print('More'),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(right: 250.0,top: 20),
                    child: Text("${post.content==null ? '' : post.content}",
                    ),
                  ),

                  InkWell(
                    onDoubleTap: () => print('Like post'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CommentScreen(post.id),
                        ),
                      );
                    },
                    child: Container(

                      margin: EdgeInsets.all(10.0),
                      width: double.infinity,
                      height: 250.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 5),
                            blurRadius: 8.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(post==null? 'Loading...' : post.imageEntities[0].image),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  iconSize: 30.0,
                                  onPressed: () => print('Like post'),
                                ),
                                Text(
                                  "${post==null? '0' : post.amount_like}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.chat),
                                  iconSize: 30.0,
                                  onPressed: () {},
                                ),
                                Text(
                                  "${post==null? '0' : post.amount_comment}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark_border),
                          iconSize: 30.0,
                          onPressed: () => print('Save post'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget PostMenu() {
    return Card(

      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.orange.withAlpha(200),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            )),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage("images/04.jpg"),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Xin chào ${globals.isLoggedIn==false ? "" : globals.loginResponse.name}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(height: 30.0),
            TextField(
              decoration: InputDecoration(
                  hintText: "Bạn đang nghĩ gì",
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: Icon(Icons.filter_list),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PostScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}





