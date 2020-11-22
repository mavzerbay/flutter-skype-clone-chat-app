import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/provider/user_provider.dart';
import 'package:skype_clone/resources/auth_methods.dart';
import 'package:skype_clone/screens/chat_screens/widgets/cached_image.dart';
import 'package:skype_clone/screens/page_views/chats/widgets/shimmering_logo.dart';
import 'package:skype_clone/screens/screens.dart';
import 'package:skype_clone/widgets/custom_appbar.dart';

class UserDetailsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signOut() async {
      final bool isLoggedOut = await AuthMethods().signOut();

      if (isLoggedOut) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          CustomAppBar(
            title: ShimmeringLogo(),
            actions: [
              FlatButton(
                onPressed: () => signOut(),
                child: Text(
                  "Çıkış Yap",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.maybePop(context),
            ),
            centerTitle: true,
          ),
          UserDetailsBody(),
        ],
      ),
    );
  }
}

class UserDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          CachedImage(
            user.profilePhoto,
            isRound: true,
            radius: 50,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                user.email,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
