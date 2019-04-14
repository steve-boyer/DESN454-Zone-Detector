import gab.opencv.*;
import processing.video.*;
import java.awt.*;

 // Needed for connecting to Arduino with Firmata
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

Capture video;
OpenCV opencv;

int zone1pin = 13;
int zone2pin = 12;
int zone3pin = 11;
int zone4pin = 10;

boolean zone1;
boolean zone2;
boolean zone3;
boolean zone4;
boolean isLeft;
boolean isTop;

void setup() {
  size(640, 480);
  
  arduino = new Arduino(this, "/dev/cu.usbmodem1461", 57600);

  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
//  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  arduino.pinMode( zone1pin, arduino.OUTPUT );
  arduino.pinMode( zone2pin, arduino.OUTPUT );
  arduino.pinMode( zone3pin, arduino.OUTPUT );
  arduino.pinMode( zone4pin, arduino.OUTPUT );

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);
  PVector loc = opencv.max();
  image(video, 0, 0 );

  if( loc.x <= width/4 ) {
    isLeft = true;
    stroke(255, 0, 0);
  } else {
    isLeft = false;
    stroke( 0, 255, 0 );
  }
  if( loc.y <= height/4 ) {
    isTop = true;
    fill(0, 0, 255);
  } else {
    isTop = false;
    fill( 0, 0, 0 );
  }
  
  strokeWeight(.5);
  //fill(0,0,0);
  ellipse(loc.x, loc.y, 12, 12);
  
  zone1 = isLeft && isTop;
  zone2 = !isLeft && isTop;
  zone3 = isLeft && !isTop;
  zone4 = !isLeft && !isTop;
  
  arduino.digitalWrite( zone1pin, zone1?arduino.HIGH:arduino.LOW );
  arduino.digitalWrite( zone2pin, zone2?arduino.HIGH:arduino.LOW );
  arduino.digitalWrite( zone3pin, zone3?arduino.HIGH:arduino.LOW );
  arduino.digitalWrite( zone4pin, zone4?arduino.HIGH:arduino.LOW  );

}

void captureEvent(Capture c) {
  c.read();
}
