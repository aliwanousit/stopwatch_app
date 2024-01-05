import 'dart:async';

import 'package:flutter/material.dart';

class HomeWatch extends StatefulWidget {
  const HomeWatch({super.key});

  @override
  State<HomeWatch> createState() => _HomeWatchState();
}

class _HomeWatchState extends State<HomeWatch> {
 int seconds=0; int minutes=0; int hours=0;
 String digitaleseconds="00";
 String digitaleminutes="00";
 String digitalehours="00";
 Timer? timer;
 bool started=false;
 List laps=[];

 void stop(){
  timer!.cancel();
  setState(() {
    started=false;
  });
 }

 void reset(){
  timer!.cancel();
  setState(() {
    seconds=0;
    minutes=0;
    hours=0;
    digitaleseconds="00";
    digitaleminutes="00";
    digitalehours="00";
    started=false;
  });
 } 
 
 void addlaps(){
  String lap="$digitalehours:$digitaleminutes:$digitaleseconds";
  setState(() {
    laps.add(lap);
  });
 }

 void start(){
  started=true;
  timer=Timer.periodic(Duration(seconds: 1), (timer) {
    int localSecond=seconds+1;
    int localMinute= minutes;
    int localHour= hours;

    if(localSecond >59){
      if(localMinute > 59){
        localHour++;
      }else{
        localMinute++;
        localSecond=0;
      }
    }
    setState(() {
      seconds=localSecond;
      minutes=localMinute;
      hours=localHour;
      digitaleseconds=(seconds>= 10)? "$seconds":"0$seconds";
      digitaleminutes=(minutes>= 10)? "$minutes":"0$minutes";
      digitalehours=(hours>= 10)? "$hours":"0$hours";
    });
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        padding: const EdgeInsets.all(16),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Container(
              padding: const EdgeInsets.only(top: 20),
               child:const Center(
                child: Text(
                  "Stop Watch app",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                         ),
             ),
            const SizedBox(height: 20,),
             Center(
              child: Text("$digitalehours:$digitaleminutes:$digitaleseconds",
              style:const TextStyle(color: Colors.white,fontSize: 80),
              ),
            ),
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: const Color(0xFF323F68),
                borderRadius: BorderRadius.circular(8)
              ),
              child: ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context,index){
                  return Container(
                    padding:const  EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Lap n${index+1}",style:const TextStyle(
                          color: Colors.white,fontSize: 16
                        ),),
                        Text("${laps[index]}",style:const TextStyle(
                          color: Colors.white,fontSize: 16
                        ),),
                      ],
                    ),
                  );
                }),
            ),
            const SizedBox(height: 20,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: MaterialButton(onPressed: (){
                  (!started)? start():stop();
                },
                shape:const StadiumBorder(
                  side: BorderSide(color: Colors.lightBlueAccent)
                ),
                child:  Text((!started)? "Start":"Pause",style:TextStyle(color:Colors.white), ),
                )),
                const SizedBox(width: 6,),
                IconButton(onPressed: (){addlaps();},color: Colors.white ,icon: Icon(Icons.flag)),
                const SizedBox(width: 6,),
                    Expanded(child: MaterialButton(onPressed: (){
                      reset();
                    },
                    color: Colors.lightBlue,
                shape:const StadiumBorder(),
                child: const Text("Reset",style:TextStyle(color:Colors.white), ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
