// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/listen_stream.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_config.dart';

class InitialScreen extends ConsumerWidget {
  InitialScreen({Key? key, required this.client}) : super(key: key);
  final HttpClient client;
  late WebSocket socket;

  @override
  Widget build(BuildContext context, ref) {
    final sockConnect = ref.watch(sockConnectprovider(client));

    return sockConnect.when(
      data: (socket) {
        this.socket = socket;
        this.socket.pingInterval = const Duration(seconds: 2);
        return OnBoardingPage(client: client, socket: this.socket);
      },
      error: (e, stk) {
        print(e);
        Future.delayed(const Duration(milliseconds: 700), (() {
          ref.refresh(sockConnectprovider(client));
        }));
        return const Scaffold(
          backgroundColor: Colors.black,
          body: NoticeWidget(
            assetImageName: "images/server_error.png",
            text1: "Server unavailable",
            text2: "Retrying...",
          ),
        );
      },
      loading: () => const Scaffold(
        backgroundColor: Colors.black,
        body: NoticeWidget(
          assetImageName: "images/server.png",
          text1: "Looking for server",
          text2: "Connecting...",
        ),
      ),
    );
  }
}

class NoticeWidget extends StatelessWidget {
  const NoticeWidget({
    Key? key,
    required this.assetImageName,
    required this.text1,
    required this.text2,
    this.loadingColor,
  }) : super(key: key);

  final String assetImageName;
  final String text1;
  final String text2;
  final Color? loadingColor;

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
        child: Flex(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      direction: Axis.vertical,
      children: [
        Container(),
        Flexible(
          child: SizedBox(
            height: 100,
            child:
                Image(image: AssetImage(assetImageName), fit: BoxFit.fitWidth),
          ),
        ),
        Column(children: [
          Text(text1,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text(text2,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
        ]),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 6, 35, 20),
            child: LinearProgressIndicator(color: loadingColor ?? Colors.red),
          ),
        )
      ],
    ));
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Spacer(),
      Column(children: [
        Spacer(),
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: child,
          ),
        )),
        SizedBox(height: 32)
      ]),
      Spacer(),
    ]);
  }
}
