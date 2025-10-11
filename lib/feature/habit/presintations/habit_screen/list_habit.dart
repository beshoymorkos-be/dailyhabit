import 'package:dailyhabitd/feature/habit/presintations/habit_screen/details_habit.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/constent/app_theme.dart';

class ListHabit extends StatefulWidget {
  const ListHabit({super.key,required this.index});
 final int  index;

  @override
  State<ListHabit> createState() => _ListHabitState();
}

class _ListHabitState extends State<ListHabit> {
  late int counter=0;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
   final pre= calculateMonthlyAttendance(now.year,
        now.month,
        now.day, 4,
        counter);
    return
       Container(
        margin: EdgeInsets.all(10),
        decoration:  BoxDecoration(
          gradient: widget.index.isEven? AppTheme.HabitGradient:
          AppTheme.HabitGradient2,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
         padding: EdgeInsets.all(8),
          child:
           ListTile(
                 leading: Icon(Icons.water_drop,
                   color: Colors.blueAccent,),
              title:InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(DetailsHabit.routeName);
                },
                child: Row(
                  children: [
                    Text('Drink Water',
                      style: Theme.of(context).textTheme.bodyMedium,),
                    const SizedBox(width: 20,),
                    CircularPercentIndicator(
                      animation: true,
                      radius: 22.0,
                      lineWidth: 2.0,
                      percent: pre/100,
                      center:  Text(
                        "${pre.toStringAsFixed(1)}%",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      progressColor: Colors.blue,
                      backgroundColor: Colors.grey.shade300,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    const SizedBox(width: 20,),
                    Text('${counter}/4',
                      style: Theme.of(context).textTheme.bodyMedium,),
                  ],
                ),
              ),
             trailing: counter >= 4 ? Icon(Icons.done,size: 30,
               color: AppTheme.primaryMint,):
             InkWell(
               onTap: () {
                 setState(() {
                   counter++;
                 });
               },
               child: Container(
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   gradient: AppTheme.mainGradient,
                   borderRadius: BorderRadius.circular(100),
                 ),
                 child: Icon(Icons.add,color: Colors.white,),
               ),
             ),


            ),
          ),


    );
  }

  double calculateMonthlyAttendance( int year, int month,int day,int time,int counter) {
    int totalMeetings = time;

    if (totalMeetings == 0 && counter>time ) return 0;

    double ratio = counter / totalMeetings;

    if (ratio > 1.0) ratio = 1.0;

    return ratio*100;
  }

}
