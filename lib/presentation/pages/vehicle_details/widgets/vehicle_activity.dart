import 'package:flutter/material.dart';

class VehicleActivity extends StatelessWidget {
  VehicleActivity({required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width * .32 + 15,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
                spreadRadius: 0),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    'Vehicle Activity',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff191919),
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                        height: 15,
                        child: Icon(Icons.sort, color: Colors.black, size: 20)),
                  )
                ],
              ),
              Divider(),
              SizedBox(height: 5),
              Container(
                height: screenSize.height * .5,
                child: ListView.separated(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int i) {
                    return ActivityItem(
                        email: email,
                        name: 'Alex Ayso',
                        dateTime: '9-23-2021 - 1:52 pm - (19 hours ago)',
                        activity:
                            'Changed the target bid price to \$30,000 on a 2018 ACURA ILX Base Clean');
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 30);
                  },
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'SHOW ALL ACTIVITIES',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ]));
  }
}

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    Key? key,
    required this.email,
    required this.name,
    required this.dateTime,
    required this.activity,
  }) : super(key: key);

  final String email;
  final String name;
  final String dateTime;
  final String activity;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: CircleAvatar(),
        ),
        const SizedBox(width: 5),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  child: SelectableText(
                    name,
                    style: TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  child: SelectableText(
                    ' @$email',
                    style: TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 12,
                        color: Color(0xff797979)),
                  ),
                ),
              ],
            ),
            SelectableText(dateTime,
                style: TextStyle(
                  color: Color(0xff18A0FB),
                  fontSize: 12,
                )),
            const SizedBox(height: 10),
            SelectableText('Activity',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                )),
            SelectableText(activity,
                style: TextStyle(
                  color: Color(0xff797979),
                  fontSize: 12,
                ))
          ],
        ),
      ],
    ));
  }
}
