import 'package:flutter/material.dart';
import 'package:searchapi/api.dart';
import 'package:searchapi/search.dart';
import 'package:searchapi/user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FetchUser _userList = FetchUser();

  // @override
  // void initState() {
  //   FetchUser().getUserList();
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title:Text('LIST'),
          actions: [
             IconButton(icon: Icon(Icons.search),
             onPressed: () {
               showSearch(context: context, delegate: SearchUser());
             },),

          ],
        ),
        body: Container(
            child: FutureBuilder<List<Userlist>>(
                future: _userList.getUserList(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                              title: Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${data?[index].id}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                 Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'NAME - ${data?[index].name}',
                                        style: TextStyle(fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        'EMAIL - ${data?[index].email}',
                                      ),
                                      Text(
                                        'USERNAME - ${data?[index].username}',
                                      ),
                                      Text(
                                        'WEBSITE - ${data?[index].website}',
                                      ),
                                      Text(
                                        'STREET - ${data?[index].address?.street}',
                                      ),
                                      Text(
                                        'CITY - ${data?[index].address?.city}',
                                      ),
                                      Text(
                                        'ZIPCODE - ${data?[index].address?.zipcode}',
                                      ),
                                    ],
                                  )
                                ],
                              )));
                    },
                  );
                }),
          ),
      ),
    );
  }
}
