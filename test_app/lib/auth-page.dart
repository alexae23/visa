import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'utils.dart';
import 'package:visa/fb.dart';
import 'package:visa/auth-data.dart';
import 'package:visa/discord.dart';
import 'package:visa/twitch.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key key, @required this.thirdParty}): super(key: key);

  final String thirdParty;

  @override
  Widget build(BuildContext context) {
    WebView authenticate = _getThirdPartyAuth(context);

    return Scaffold(
      appBar: Utils.getAppBar(context),
      body: authenticate,
    );
  }

  WebView _getThirdPartyAuth(context){
    var done = (AuthData authData){
      print(authData);

      Navigator.pushReplacementNamed(
          context, '/complete-profile', arguments: authData
      );
    };

    switch(thirdParty){
      case 'fb': return FaceBookAuth().visa.authenticate(
          clientID: '329705311682184',
          redirectUri: 'https://www.eswagers.com/oauth',
          scope: 'public_profile,email',
          state: 'fbAuth',
          onDone: done
      );

      case 'twitch': return TwitchAuth().visa.authenticate(
          clientID: 'e4iaw7qsbc7gg0zsrwyobd2o9l5dqq',
          redirectUri: 'https://www.eswagers.com/oauth',
          state: 'twitchAuth',
          scope: 'user:read:email',
          onDone: done
      );

      case 'discord': return DiscordAuth().visa.authenticate(
          clientID: '782031829334622208',
          redirectUri: 'https://www.eswagers.com/oauth',
          state: 'discordAuth',
          scope: 'identify email',
          onDone: done
      );
    }

    return null;
  }
}