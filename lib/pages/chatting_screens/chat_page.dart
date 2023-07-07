// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = '/chat';

  // static Route route({required UserMatch userMatch}) {
  //   return MaterialPageRoute(
  //     settings: RouteSettings(name: routeName),
  //     builder: (context) => ChatScreen(userMatch: userMatch),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          //backgroundColor: Color.fromARGB(255, 221, 221, 221),
          backgroundColor: Color.fromRGBO(249, 200, 6, 1),
          elevation: 0,
          // iconTheme: IconThemeData(
          //   color: Theme.of(context).primaryColor,
          // ),
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    'https://i.scdn.co/image/ab6761610000e5eb1a992102d607e2b48095d5e4'),
              ),
              SizedBox(height: 5),
              Text(
                //userMatch.matchedUser.name,
                "Mrs Piggy",
                style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              )
            ],
          ),
        ),
      ),
      body: Column(children: [
        Expanded(
            child: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5, //change to no. of msgs
              itemBuilder: (context, index) {
                return ListTile(
                    //the first display msg
                    //title: userMatch.chat![0].messages[index].senderId ==1
                    title: Align(
                  alignment: Alignment.topRight,
                  child: Text("in progress..."),
                  // child: Container(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.all(
                  //                         Radius.circular(8.0),
                  //                       ),
                  //                       color: Theme.of(context)
                  //                           .backgroundColor),
                  //                   child: Text(
                  //                     userMatch
                  //                         .chat![0].messages[index].message,
                  //                     style: Theme.of(context)
                  //                         .textTheme
                  //                         .headline6,
                  //                   ),
                  //                 ),
                ));
              }),
        ))
      ]),
    );
  }
}
