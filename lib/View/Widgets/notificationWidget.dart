import 'package:flutter/material.dart';
class notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        titleSpacing: 10.0,
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
                      ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context , index){
                  return buildNotificationsItem();
                }, 
                separatorBuilder: (context , index){
                  return SizedBox(height: 20.0,);
                },
                 itemCount: 15),
            )

          ],
        ),
      ),
     );
  }
  
 Widget buildNotificationsItem(){
   return   Row(
              children: [            
                const CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                    AssetImage('images/123.png')
                    ),   
                const SizedBox(width: 20.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Remmeber your next donation',
                      style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 3.0,),
                      Row(
                        children: [
                          Expanded(
                            child: Text('dcjhguytvh11111111111111111111111111111111111111112222svutsdf',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,)),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              width: 7.0,
                              height: 7.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          
                          Text('02:00 pm'),
                        ],
                      )      
                    ],
                  ),
                )
              ],
            ) ;


  }


}