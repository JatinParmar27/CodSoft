import 'package:chat_application/Pages/chat_page.dart';
import 'package:chat_application/Services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              _signOut();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: _buildUserList(),
    );
  }

  // build al list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final users = snapshot.data!.docs
              .where((doc) =>
                  _auth.currentUser?.email !=
                  (doc.data() as Map<String, dynamic>)['email'])
              .toList();

          if (users.isEmpty) {
            return const Center(
              child: Text('No Other Users Found'),
            );
          }

          return ListView(
                  children: snapshot.data!.docs
                      .map<Widget>((doc) => _buildUserListItem(doc))
                      .toList(),
                );
              
            
          
        }
    );
  }

  // build Individual user list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return ListTile(
        title: Text(data['email']),
        onTap: () {
          // pass the clicked user's UID to the chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  reciverUserEmail: data['email'],
                  reciverUserID: data['uid'],
                ),
              ));
        });
  }
}
