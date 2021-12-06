import 'package:flutter/material.dart';
import 'package:searchapi/api.dart';
import 'package:searchapi/user.dart';

class SearchUser extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },);
  }
  FetchUser _userList = FetchUser();

  @override
  Widget buildResults(BuildContext context) {
    return
      Container(
        child: FutureBuilder<List<Userlist>>(
            future: _userList.getUserList(query: query),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
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
      );
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Users'),
    );
  }
}