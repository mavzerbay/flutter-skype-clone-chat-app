import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/models/contact.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/provider/user_provider.dart';
import 'package:skype_clone/resources/auth_methods.dart';
import 'package:skype_clone/resources/chat_methods.dart';
import 'package:skype_clone/screens/chat_screens/chat_screen.dart';
import 'package:skype_clone/screens/chat_screens/widgets/cached_image.dart';
import 'package:skype_clone/screens/page_views/chats/widgets/last_message_container.dart';
import 'package:skype_clone/screens/page_views/chats/widgets/online_dot_indictator.dart';
import 'package:skype_clone/widgets/custom_tile.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final AuthMethods _authMethods = AuthMethods();

  ContactView(this.contact);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;
          return ViewLayout(
            contact: user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final ChatMethods _chatMethods = ChatMethods();

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => ChatScreen(receiver: contact))),
      title: Text(
        contact?.name ?? "..",
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Arial",
          fontSize: 19,
        ),
      ),
      subTitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
            senderId: userProvider.getUser.uid, receiverId: contact.uid),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: [
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndictator(
              uid: contact.uid,
            )
          ],
        ),
      ),
    );
  }
}
