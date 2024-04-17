import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController textEditingController;
  var dateTime;
  var timeStamp;
  var anotherDateTime;
  var newdatetime;

  var selectedDate;
  var selectedTime;

  @override
  void initState() {
    dateTime = DateTime.now();
    timeStamp = dateTime.millisecondsSinceEpoch;
    anotherDateTime = DateFormat("yyyy/MM/dd HH:mm:ss").format(dateTime);
    // newdatetime=DateTime.parse(anotherDateTime);
    // anotherDateTime=DateTime.fromMicrosecondsSinceEpoch(timeStamp);
    textEditingController = TextEditingController(text: "default text");
    //initialize
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay(hour: 2, minute: 20);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  String str = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(focusNode2);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(userInput: str),
                      // SecondPage(userInput: textEditingController.text),
                    ));
              },
              icon: Icon(Icons.arrow_forward))
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.pink, fontSize: 20),
                //maxLength: 2,// number of characters
                //   maxLines: 2,
                textCapitalization: TextCapitalization.words,
                //every word first letter caps or letter
                //  keyboardType:TextInputType.number,
                autofocus: true,
                onChanged: (value) {
                  str = value;
                },
                focusNode: focusNode1,
                //controller: textEditingController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                autofocus: true,
                onChanged: (value) {
                  str = value;
                },

                focusNode: focusNode2,
                //controller: textEditingController,
                //    decoration: InputDecoration.collapsed(hintText: "password"),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.add), //inside
                    // icon: Icon(Icons.add),//outside
                    hintText: "password",
                    label: Text("pass"),
                    border: OutlineInputBorder()),
              ),

              SizedBox(
                height: 20,
              ),

              Text("$dateTime"),
              Text("$timeStamp"),
              Text("$anotherDateTime"),
              //   Text("$newdatetime"),
              Text(
                  "selected date ${DateFormat("dd-MM-yyyy").format(selectedDate)}"),
              ElevatedButton(
                  onPressed: () {
                    selectDate(context);
                  },
                  child: Text("Select Date")),

              Text(
                "selected time ${selectedTime.hourOfPeriod}:${selectedTime.minute}${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}",
              ),

              ElevatedButton(
                  onPressed: () {
                    selectTime(context);
                  },
                  child: Text("Select Time"))
            ],
          ),
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(
        2025,
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedTime = picked;
      });
    }
  }
}

class SecondPage extends StatefulWidget {
  final String userInput;

  const SecondPage({Key? key, required this.userInput}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  var initial = "one";
  var droplist = ["one", "two", "three", "four", "five"];
  var ischecked = false;
  var sex = "male";
  var groupvalue = "afternoon";
  var isSwitch = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Validation"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null||value.isEmpty) {
                    return "this field is required";
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(onPressed: () {
              formKey.currentState!.validate();
            }, child: Text("validate")),
            // Text(
            //   widget.userInput,
            //   style: TextStyle(fontSize: 20, color: Colors.pink),
            // ),
            DropdownButton(
                icon: Icon(Icons.arrow_downward),
                iconSize: 20,
                value: initial,
                items: droplist
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                style: TextStyle(fontSize: 20, color: Colors.blue),
                underline: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.deepOrange,
                  ))),
                ),
                onChanged: (String? value) {
                  setState(() {
                    initial = value!;
                  });
                }),

            Checkbox(
              activeColor: Colors.pink,
              value: ischecked,
              checkColor: Colors.white,
              onChanged: (value) {
                ischecked = value!;
                setState(() {});
              },
            ),

            Radio(
              value: "male",
              groupValue: sex,
              onChanged: (value) {
                if (value != null) sex = value;
                setState(() {});
              },
            ),
            Radio(
              value: "female",
              groupValue: sex,
              onChanged: (value) {
                if (value != null) sex = value;
                setState(() {});
              },
            ),

            Container(
              color: Colors.blue,
              child: RadioListTile(
                title: Text("Morning"),
                value: "morning",
                groupValue: groupvalue,
                onChanged: (value) {
                  groupvalue = value!;
                  setState(() {
                    print(groupvalue);
                  });
                },
              ),
            ),
            RadioListTile(
              subtitle: Text("sub title"),
              title: Text("Afternoon"),
              value: "afternoon",
              groupValue: groupvalue,
              onChanged: (value) {
                groupvalue = value!;
                setState(() {});
              },
            ),

            Switch(
              value: isSwitch,
              onChanged: (value) {
                if (value != null) {
                  isSwitch = value;
                  setState(() {});
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
