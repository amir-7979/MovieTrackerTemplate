import 'package:flutter/material.dart';
import '../../models/session_model.dart';
import '../../utilities/http_helper.dart';

class ActiveSessionsScreen extends StatelessWidget {
  static const routeName = '/active-sessions-screen';

  const ActiveSessionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Session')),
      body: FutureBuilder(
          future: activeSessions(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ActiveSessionWidget(snapshot.data, context);
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 4,
                ),
              );
            }
          }),
    );
  }

  Widget ActiveSessionWidget(Session session, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Text('Current Session'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Card(
            color: Colors.black12,
            child: Column(
              children: [
                ListTile(
                  leading: Icon((session.thisDevice.deviceOs == 'android')
                      ? Icons.android_outlined
                      : Icons.phone_iphone),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${session.thisDevice.deviceModel}'),
                      Text(
                          '${session.thisDevice.appName} - ${session.thisDevice.appVersion}'),
                    ],
                  ),
                  subtitle: Text('${session.thisDevice.ipLocation}'),
                ),
                SizedBox(
                  height: 60,
                  child: ListTile(
                    leading: const Icon(Icons.warning),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  useSafeArea: false,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Alert'),
                                      content: const Text(
                                          'Do you want to terminate all other sessions?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Ok'),
                                          onPressed: () async {
                                            await forceLogoutAll();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Text(
                              'Terminate all other sessions',
                              style: TextStyle(color: Colors.red),
                            ),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Text('Active Session'),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Card(
              color: Colors.black12,
              child: ListView.builder(
                  itemCount: session.activeSessions.length,
                  itemBuilder: (_, int index) {
                    return ListTile(leading: Icon((session.activeSessions[index].deviceOs == 'android') ? Icons.android_outlined : Icons.phone_iphone),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${session.activeSessions[index].deviceModel}'),
                          Text('${session.activeSessions[index].appName} - ${session.activeSessions[index].appVersion}'),
                        ],
                      ),
                      subtitle: Text('${session.activeSessions[index].ipLocation}'),
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
