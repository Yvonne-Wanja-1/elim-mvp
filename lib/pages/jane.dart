import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JanePage extends StatelessWidget {
  const JanePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Jane Achieng, 17',
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
                      child: ClipOval(
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
        ),
        
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset(
                    'images/girl.png',
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
                  child: Text('''At 17, Achieng faced trauma and isolation as a teen mother. Through Elim Trust's MATS Dialogue program, she found a supportive community, regained her confidence, and is now pursuing her education.

When she first joined the program, Achieng carried the heavy burden of shame, rejection, and uncertainty about her future. She felt invisible—misunderstood by her peers and judged by her community. But MATS Dialogue became a turning point. The safe, nurturing space allowed her to share her story without fear of stigma. She discovered she wasn’t alone. Other young mothers were walking similar paths—and together, they began to heal.

Through group counseling, life skills training, and mentorship, Achieng began to believe in herself again. She learned how to set boundaries, advocate for her needs, and dream beyond her current circumstances. With Elim Trust’s help, she re-enrolled in school, determined to give her child a brighter future.

Today, Achieng is not only focused on her education, but she’s also become a peer mentor—encouraging other young mothers to rise above their pain and pursue their goals. What once seemed like the end of her story is now just the beginning.

Elim Trust didn’t just support Achieng—they helped her reclaim her voice, her dreams, and her power.''',
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
        Navigator.pushNamed(context, '/pastor');
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
            Navigator.pushNamed(context, '/albert');
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