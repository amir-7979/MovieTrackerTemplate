import 'package:flutter/material.dart';
import '../../models/session_model.dart';
import '../../utilities/http_helper.dart';

class ActiveSession extends StatelessWidget {
  const ActiveSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: activeSessions(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return FutureWidget(snapshot.data);
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 4,
            ),
          );
        });
  }
}

class FutureWidget extends StatelessWidget {
  final Session _session;

  FutureWidget(this._session);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
        child: Column(
          children: [
            const Text('Current Session'),
            SizedBox(
              height: 200,
              child: Card(
                elevation: 10,
                color: Colors.grey,
                child: Column(
                  children: [
                    SessionItem(_session.thisDevice),
                     const Divider(height: 1),
                     const InkWell(
                        onTap: forceLogoutAll,
                        child: ListTile(
                          minLeadingWidth: 20,
                            leading: Icon(Icons.stop_circle, size: 20),
                            title: Text('Terminate all other session',
                                style: TextStyle(color: Colors.red))),
                      ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 0, 3),
              child: Text('Logout all devices except for this one'),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 0, 3),
              child: Text('Active Sessions'),
            ),
            Card(
              elevation: 10,
              color: Colors.grey,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _session.activeSessions.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return SessionItem(_session.activeSessions[index]);
                  }),
            ),
          ],
        ),

    );
  }
}

Widget SessionItem(Device device) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            const Icon(Icons.phone_android, size: 30),
            Expanded(
              child: Column(
                children: [
                  Text(device.deviceModel),
                  Text(device.appName + "  " + device.deviceOs),
                  Text(device.ipLocation + "  " + device.loginDate),
                ],
              ),
            ),
          ],
        ),
      ));
}
