import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID, required this.userName}) : super(key: key);
  final String callID;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1863495586, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: '786f09f1f3d1cc9538e6a1727a1ac89dbd9e82ba8ca281af238b036f1781468f', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: 'userName${123}',
      userName: userName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall() 
        ..onOnlySelfInRoom = (_) => Navigator.of(context).pop(),
    );
  }
}