import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PastorPage extends StatelessWidget {
  const PastorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pastor Peter Kamau, 54',
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
                    'images/pastor.png',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text('Spiritual Leadership Trainee',
              style: GoogleFonts.dancingScript(
                color: Colors.blue,

              ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('''Seeing trauma in his congregation, Pastor Kamau joined Elim Trust's Leadership Training. With new tools, he now fosters healing and resilience within his community, creating a supportive environment for all.

Through the training, he learned how to identify emotional wounds, offer trauma-informed care, and lead with empathy. He began implementing what he learned during sermons, counseling sessions, and youth outreach programs. The shift was powerful—members began to open up, share their struggles, and find strength in one another.

Pastor Kamau has become a beacon of hope in his community. By empowering others to process pain, build inner strength, and support one another, he’s helping to break the cycle of silence and suffering. Thanks to Elim Trust, his church is no longer just a place of worship—it’s now a sanctuary of healing and transformation.''',
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
        Navigator.pushNamed(context, '/albert');
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
            Navigator.pushNamed(context, '/jane');
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