//
// video_delay
//


import processing.video.*;
import java.util.*;


Capture cam;
ArrayDeque<PImage> buffer = new ArrayDeque<PImage>();


void setup()
{
    size(640, 960);
String[] cameras = Capture.list();

    if (cameras.length == 0)
    {
        println("There are no cameras available for capture.");
        exit();
    }
    else
    {
        println("Available cameras:");
        for (int i = 0; i < cameras.length; i++)
            println(cameras[i]);

        cam = new Capture(this, cameras[0]);
        cam.start();
    }
}


void draw()
{
    if (cam.available())
        cam.read();

    PImage temp = cam.copy();
    buffer.addFirst(temp);

    PImage first = buffer.getFirst(); // get*() does not remove the PImage
    image(first, 0, 0);

    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("frames: " + buffer.size(), width/2, 480);

    if (frameCount < 300)
      return;

    PImage last = buffer.removeLast();
    image(last, 0, 480);
}
