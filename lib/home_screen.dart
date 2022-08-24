import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var data;
  Future<void> getUsers() async {
    final responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (responce.statusCode == 200) {
      data = jsonDecode(responce.body.toString());
      return data;
    } else {
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Complex Json WithOut Model"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  if (Platform.isIOS) {
                    return const CupertinoActivityIndicator();
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        borderOnForeground: true,
                        color: Color.fromARGB(178, 138, 238, 143),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Name: ${data![index]['name']}'),
                                    Text('ID: ${data![index]['id']}'),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Username: ${data![index]['username']}'),
                                    Text('Email: ${data![index]['email']}'),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Address: ${data![index]['address']['city']}'),
                                    Text(
                                        'Lat: ${data![index]['address']['geo']['lat']}'),
                                    Text(
                                        'Lng: ${data![index]['address']['geo']['lng']}'),
                                  ]),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
