import 'package:flutter/material.dart';
import 'package:gt_bank_app/api_models/api_request_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int likesCount = 0;

  var result = 'No response yet';

  void addLikes() {
    setState(() {
      likesCount++;
    });
  }

  void makeAPICall() async {
    var response = await HubspotClient().getName('/users').catchError((err) {});
    if (response == null) return;
    debugPrint('successful:$response');

    setState(() {
      result = response;
    });

    // var users = userFromJson(response);
    // debugPrint('Users count: ' + users.length.toString());
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome To Your Dashboard !'),
            ElevatedButton(onPressed: addLikes, child: const Text('Add Likes')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: makeAPICall,
                child: const Text('Make API Call'),
              ),
            ),
            Text(result)
          ],
        ),
      ),
    );
  }
}
