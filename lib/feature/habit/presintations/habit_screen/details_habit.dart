import 'package:dailyhabitd/feature/habit/presintations/habit_screen/edit_habit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constent/app_theme.dart';

class DetailsHabit extends StatelessWidget {
  static const routeName='detail';
  const DetailsHabit({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [10.0, 20.0, 40.0, 55.0, 60.0, 62.0, 65.0];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Container(
      decoration: BoxDecoration(
          gradient: AppTheme.HabitGradient
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
            title: Text('Meditate',
              style: Theme.of(context).textTheme.titleLarge,),

        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60,),
              Container(

                height: 280,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),

                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Weekly Progress",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          maxY: 70,
                          gridData: FlGridData(show: true,
                              horizontalInterval: 10,drawVerticalLine: false,
                          ),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 10,),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  final index = value.toInt();
                                  if (index < 0 || index >= days.length) {
                                    return const SizedBox.shrink();
                                  }
                                  final day = days[index];
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    space: 8,
                                    child: Text(
                                      day,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          barGroups: List.generate(data.length, (index) {
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: data[index],
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF4FC3F7), Color(0xFF80CBC4)],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),)
                      ]
                    ),
                    child: Column(
                      children: [
                        Text('Current Streak',
                          style: Theme.of(context).textTheme.bodyMedium,),
                        SizedBox(height: 4,),
                        Text('7 Days',style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),)
                        ]
                    ),
                    child: Column(
                      children: [
                        Text('Success Rate',
                          style: Theme.of(context).textTheme.bodyMedium,),
                        SizedBox(height: 4,),
                        Text('90%',style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                  ),Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),)
                        ]
                    ),
                    child: Column(
                      children: [
                        Text('Total Times',
                          style: Theme.of(context).textTheme.bodyMedium,),
                        SizedBox(height: 4,),
                        Text('28 Time',style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 60,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(EditHabit.routeName);
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(vertical: 8,),
                  decoration: const BoxDecoration(
                    gradient: AppTheme.buttonGradient,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Center(
                    child: Text(
                      'Edit Habit',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){},
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 200.w,
                  padding: const EdgeInsets.symmetric(vertical: 8,),
                  decoration: const BoxDecoration(
                    color: Colors.red,

                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Center(
                    child: Text(
                      'Remove The Habit',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
