import 'package:flutter/material.dart';
import 'package:reminder_app/screens/importAll.dart';
import 'package:reminder_app/modals/importAll.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddTaskScreen extends StatefulWidget {

  Health health;
  Work work;
  Date1 date;
  int index;
  int TabControl = 0;

  static String route ="addtask";

  AddTaskScreen({
    this.health,
    this.work,
    this.date,
    this.index,
    this.TabControl,
  });

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> with TickerProviderStateMixin {

  bool _loading = false;
  TabController controller;


  void initState(){
    super.initState();
    if(widget.health != null){
      controller = new TabController(initialIndex: 0, length: 3, vsync: this);
    }
    else if(widget.work != null){
      controller = new TabController(initialIndex: 1, length: 3, vsync: this);
    }
    else if(widget.date != null){
      controller = new TabController(initialIndex: 2, length: 3, vsync: this);
    }
    else{
      controller = new TabController(initialIndex: widget.TabControl, length: 3, vsync: this);
    }

  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    disableFocus() {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild.unfocus();
      }
    }

    return GestureDetector(
      onTap: disableFocus,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Image.asset("assets/images/logo.png")),
              title: Text(
                "Reminder",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
              backgroundColor: Colors.blue,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 28,),
                      onPressed: (){
                        Navigator.pop(context);
                      }
                  ),
                ),
              ],
              bottom: TabBar(
                controller: controller,
                  tabs: <Tab>[
                    new Tab(
                      child: Row(
                        children: [
                          Icon(Icons.local_hospital, ),
                          SizedBox(width: 5,),
                          Text(
                            "Health",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Tab(
                      child: Row(
                        children: [
                          Icon(Icons.work, ),
                          SizedBox(width: 10,),
                          Text(
                            "Work",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Tab(
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, ),
                          SizedBox(width: 10,),
                          Text(
                            "Dates",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
              ),

            ),
            body: TabBarView(
              controller: controller,
              children: [
                AddHealthTaskScreen(health: widget.health, healthindex: widget.index,),
                AddWorkTaskScreen(work: widget.work, workindex: widget.index,),
                AddDateTaskScreen(date: widget.date, dateindex: widget.index,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// bottomNavigationBar: BottomNavigationBar(
//     items: const <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home),
//         title: Text('Home'),
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.arrow_back),
//         title: Text('Back'),
//       ),
//     ],
// ),


