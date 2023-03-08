import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weparent/view/ResetPassword/enteremail_screen.dart';
import 'package:weparent/view/settings/manageAccount/editAccount/editprofile_screen.dart';
import 'package:weparent/model/user.dart';
import '../../../viewmodel/userViewModel.dart';

class ManageAccount extends StatefulWidget {
  static const imageUrl = String;
  @override
  State<ManageAccount> createState() => _ManageAccountState();

  
}



    

class _ManageAccountState extends State<ManageAccount> {
   
  String _firstname ='';
  String _lastname ='';
  String _email ='';
  String _photo ='';

 Future<void> _loadData() async {
      SharedPreferences prefs =  await SharedPreferences.getInstance();
    setState(() {
 
               _firstname =  prefs.getString('FirstName')! ;
     _lastname =  prefs.getString('LastName')!;
     _email =  prefs.getString('Email')!;
      _photo =  prefs.getString('ProfilePhoto')!;
    });
 }


@override void initState()  {
    _loadData();

    super.initState();
   

 
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFBC539F)),
        title: const Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.person_outlined),
                ),
              ),
              TextSpan(text: 'Manage account'),
            ],
          ),
        ),
        foregroundColor: const Color(0xFFBC539F),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: [
             Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 20),
                  child: ClipOval(
                    child: CircleAvatar(
                    
                      radius:110,
                      backgroundImage: NetworkImage(_photo),
                      backgroundColor: Colors.white,
                      child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFFBC539F),
                          width: 5.0,
                        ),
                      ),
                    ),
                     // The radius of the image
                    ),
                  )),
                 Row(mainAxisAlignment: MainAxisAlignment.center,children:  [
                  Text(_firstname,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                  SizedBox(width: 5),
                  Text(_lastname,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold))]),
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Text(_email,style: TextStyle(fontSize: 17,color: Colors.grey.shade500))]),
             SizedBox(height: 30,),
              _SingleSection(
                title: "Manage account",
                children: [
                  CustomListTile(
                    title: "Edit account information",
                    icon: Icons.person_pin,
                    onTap: () {
                      Navigator.pushNamed(context, "/editprofile");
                    },
                  ),
                  CustomListTile(
                    title: "Change password",
                    icon: Icons.password,
                    onTap: () {
                      Navigator.pushNamed(context, '/changepassword');
                    },
                  ),
                  CustomListTile(
                    color: Colors.red,
                    title: "Close account",
                    icon: Icons.no_accounts_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;
  final Widget? trailing;

  const CustomListTile({
    required this.title,
    required this.icon,
this.color
    ,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: color,),
      title: Text(title),
      textColor:color ,
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title!,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          Column(
            children: children,
          ),
        ],
      ),
    );
  }
}
