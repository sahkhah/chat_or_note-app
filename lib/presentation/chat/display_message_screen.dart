import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_implementation/data/source/chat/chat_firebase_impl.dart';
import 'package:flutter/material.dart';

class DisplayMessageScreen extends StatefulWidget {
  final String name;
  const DisplayMessageScreen({super.key, required this.name});

  @override
  State<DisplayMessageScreen> createState() => _DisplayMessageScreenState();
}

class _DisplayMessageScreenState extends State<DisplayMessageScreen> {
  @override
  Widget build(BuildContext context) {
    final messageStream = ChatFirebaseImpl().fetchMessage();
    return Scaffold(
      body: StreamBuilder(
        stream: messageStream,
        builder: (context, snapshot) {
          final result = snapshot.data!.docs;
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                final qds = snapshot.data!.docs[index];
                //final qds = result[index].data() as Map<String, dynamic>;
                final date = qds['time'] as Timestamp;
                final newDate = date.toDate();
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                   // vertical: 2.0,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        widget.name == qds['name']
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: 300,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.purple),
                            borderRadius:   widget.name == qds['name'] ? BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ) : BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                          ),
                          ),
                          title: Text(
                            qds['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  qds['message'],
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Text('${newDate.hour}: ${newDate.minute}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('No data. check your internet network'));
          } else {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          }
        },
      ),
    );
  }
}
