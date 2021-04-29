import 'package:flutter/material.dart';


/* return FutureBuilder(
      future: APIService.fetchUser(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
        if (snapshot.hasData) {
          List<User> posts = snapshot.data;
          return ListView(
            children: posts.map((User post) {
              return Card(
                  child: ListTile(title : Text(post.fullName),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(post.avatar),
                    ),
                    subtitle: Text(post.email),
                    onLongPress: (){
                      return Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserDetail(user: post)));
                    },
                    trailing: GestureDetector(
                      child: Icon(Icons.delete, color: Colors.red,size: 25,),
                      onTap: (){
                        confirmDeleteDialog(context, "${post.id}");
                      },
                    ),
                  ),

              );
            },
            )
                .toList(),
          );
        } else {
          return Center(child: loadingScreen(context, loadingType: LoadingType.JUMPING));
        }
      },
    );*/


class DemoBottomBar extends StatefulWidget {
  @override
  _DemoBottomBarState createState() => _DemoBottomBarState();
}



class _DemoBottomBarState extends State<DemoBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage("https://scr.vn/wp-content/uploads/2020/07/avt-cute.jpg"),
          ),
        ),
    );
  }
}
