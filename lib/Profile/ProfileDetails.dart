import 'package:flutter/material.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ListTile(
                  title: Text("Address:"),
                  subtitle: Text(""),
                ),
                ListTile(
                  title: Text("Email:"),
                  subtitle: Text(""),
                ),
                ListTile(
                  title: Text("Mobile:"),
                  subtitle: Text(""),
                ),
                Divider(),
                Center(child: Text("")),
                ListTile(
                  leading: Text("Total Carpet Area:"),
                  trailing: Text("484698886jhjhjhjhjjkj"),
                ),
                ListTile(
                  leading: Text("Square Meter"),
                  trailing: Text("4848"),
                ),
                ListTile(
                  leading: Text("Suare Feet:"),
                  trailing: Text("5986"),
                ),
                ListTile(
                  leading: Text("Agreement Amount:"),
                  trailing: Text("89565"),
                ),
                ListTile(
                  leading: Text("Due:"),
                  trailing: Text("59659"),
                ),
                Divider(
                  height: 7,
                  thickness: 7,
                ),
                ListTile(
                  leading: Text("Paid:"),
                  trailing: Text("59659"),
                ),
                Divider(
                  height: 7,
                  thickness: 7,
                ),
                ListTile(
                  leading: Text("Overdue:"),
                  trailing: Text("59659"),
                ),
                ListTile(
                  leading: Text("Balance:"),
                  trailing: Text("59659"),
                ),
                Divider(),
                ListTile(
                  leading: Text("Channel Partner:"),
                  trailing: Text("Sanket"),
                ),
                ListTile(
                  leading: Text("Address:"),
                  trailing: Text("59659"),
                ),
                ListTile(
                  leading: Text("Mobile Number:"),
                  trailing: Text("59659"),
                ),
                ListTile(
                  leading: Text("Email:"),
                  trailing: Text("59659"),
                ),
                ListTile(
                  leading: Text("GST:"),
                  trailing: Text("59659"),
                ),
                ListTile(
                  leading: Text("Interest:"),
                  trailing: Text("59659"),
                ),
                ListTile(
                  leading: Text(":"),
                  trailing: Text("59659"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
