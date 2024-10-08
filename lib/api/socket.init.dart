import 'package:appc/api/host.token.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as server;

server.Socket? socket;

class APPSocket {
  static Future<void> initSocket() async {
    socket = server.io(serversocket,
        server.OptionBuilder().setTransports(['websocket']).build());
    socket?.onConnect((data) {
      debugPrint("SOCKET CONNECTED SUCCESSFUL");
    });
    socket?.onConnectError((data) => debugPrint('SOCKET ERROR : $data'));
    socket?.onDisconnect((data) => debugPrint('SOCKET DISCONNECTED : $data'));
  }
}
