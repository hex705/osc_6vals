/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;  // a listener
int myPort  = 12001;


NetAddress  remoteLocation;  // someone to talk to
int remotePort = 12000;


void setup() {
  
  size(400,400);
  noStroke();
  frameRate(25);
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, myPort); // what does this remind you of ?
  
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
   
  remoteLocation = new NetAddress("127.0.0.1", remotePort);  // is this familiar?
  
  background(0);  
  
}



void draw() {
  
  // nothing here 
  
  // but look at the event handlers below ...
  
  for (int i = 0; i < balls.size(); i++) { // iterate through all the balls .
  
    // An ArrayList doesn't know what it is storing,
    // so we have to cast the object coming out.
    Ball theNextBall = (Ball) balls.get(i);
    theNextBall.move();
    theNextBall.display();
    if (theNextBall.offScreen()) {
      // Items can be deleted with remove(). now its gone
        balls.remove(i);
    }
    
    if (theNextBall.blocked() ) {
      // do stuff
    } 
    
    
  } 
  
  // for all the balls -- see if they are on screen
  // if they fell off dispose of them -- with remove 
  // check for hit 
  // if its a hit get the color and send it to everyone .
  color myBallColor = ball[whichBall].getColor();
  
  
}
 

void mouseReleased() {

  
  OscMessage myMessage = new OscMessage("/aClient");  // starts with an ADDRESS PATTERN --> = / + any string you like
  
  int rVal = (int)random(0,255);  
  // create the value to send
  myMessage.add( 2 );  // 0                              // add an int to the osc message
 myMessage.add(  3 );  // 1
 
  myMessage.add( 4.5 );  // 2
  
  
  
   myMessage.add(0 );  // 3 = red                            // add an int to the osc message
 myMessage.add(  127 );  // 4=gr
 
  myMessage.add( 255);  // 5=blue
  
  oscP5.send(myMessage, remoteLocation);               // actually do the sending
   
  // visualize the value sent -- bottom half of sketch
  fill(rVal);
  rect (0,height/2,width,height);
  
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  
  /* print the address pattern and the typetag of the received OscMessage */
  println("### received an osc message.");
  println("    addrpattern: " + theOscMessage.addrPattern());

 int x= theOscMessage.get(0).intValue();
   int y = theOscMessage.get(1).intValue();
    int z = theOscMessage.get(2).intValue();
     int r = theOscMessage.get(3).intValue();
      int gr = theOscMessage.get(4).intValue();
       int b = theOscMessage.get(5).intValue();
       
       // NEW BALL OBJECT HERE __ ADD to array list
       
       
       fill(r,gr,b);
       

  // visualize the value sent -- top half of sketch

  rect (0,0,width,height/2);
  
}
