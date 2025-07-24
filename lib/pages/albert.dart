import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbertPage extends StatelessWidget {
  const AlbertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Albert Ruabe, 32',
          style: GoogleFonts.dancingScript(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,


              leading: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      //margin: const EdgeInsets.only(left: 8.0), // Reduced margin to fit AppBar's leading area
                       height: 30, // Adjusted for a more standard icon button size
                       width: 30,  // Adjusted for a more standard icon button size
                      decoration: BoxDecoration(
                        color: Colors.blue, // Optional: Added a background color
                        
                        borderRadius: BorderRadius.circular(30), // Make it circular (half of height/width)
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero, // Remove default IconButton padding for better control
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24), // Standard icon size
                        onPressed: () {
                          //take to the donation page
                          Navigator.pop(context); // Corrected route
                        },
                      ),
                    ),
                  ),
        ),
        
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    'images/man1.png',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text('Mats Dialogue Participant',
              style: GoogleFonts.dancingScript(
                color: Colors.blue,

              ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('''Through Y-PREP, I have grown in self-awareness and resilience. I've learned to solve problems—not just for myself, but for my younger siblings and friends too. Despite the challenges I face at home and in school, I now approach life with confidence, purpose, and a desire to uplift others, just as Elim Trust uplifted me.
                              
                              Before joining Y-PREP, I often doubted my abilities and struggled to find hope during difficult times. But the support, mentorship, and life skills I’ve gained through the program have opened my eyes to my potential. I’ve learned the power of discipline, goal setting, and emotional intelligence. I’ve even started guiding others, offering advice and encouragement when they feel stuck or overwhelmed.
                              
                              Y-PREP has been more than just a program—it’s been a turning point in my life. I now believe that my voice matters, my dreams are valid, and I have what it takes to create a better future for myself and those around me. I’m truly grateful to Elim Trust for walking with me on this journey of growth and transformation''',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                  ),
                ),
              ),



SizedBox(height: 20,),

Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
  SizedBox(
    width: 120,
    child: ElevatedButton(
      onPressed: (){
        Navigator.pushNamed(context, '/jane');
      }, 
      child: Text('Previous',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
    ),
  ),

        SizedBox(
          width: 120,
          child: ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/pastor');
          }, 
                child: Text('Next',
                style: TextStyle(
          color: Colors.white,
                ),
                ),
                style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
            )),
        )
    ],
  ),
)

            ],
          ),
        ),
      ),
    );
  }
}