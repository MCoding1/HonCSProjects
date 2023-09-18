//
// image_filter.pde
//


PImage apcs;


RedFilter redFilter = new RedFilter();
GreenFilter greenFilter = new GreenFilter();
GreyFilter greyFilter = new GreyFilter();
MirrorFilter mirrorFilter = new MirrorFilter();


void setup()
{
    size(800, 600);
    reloadImage();
}


void reloadImage()
{
    apcs = loadImage("apcs_2022.jpg");
    apcs.resize(width, height);
}


void draw()
{
    background(0);

    image(apcs, 0, 0);
}


class ImageFilter
{
    void apply(PImage img)
    {
        img.loadPixels();
        filter(img.pixels, img.width, img.height);
        img.updatePixels();
    }

    void filter(int[] pixels, int w, int h)
    {}
}


class RedFilter extends ImageFilter
{
    void filter(int[] pixels, int w, int h)
    {
        for (int i=0; i<pixels.length; i++)
            pixels[i] &= 0x00ff0000;
    }
}


class GreenFilter extends ImageFilter
{
    void filter(int[] pixels, int w, int h)
    {
        for (int i=0; i<pixels.length; i++)
            pixels[i] &= 0x0000ff00;
    }
}


class GreyFilter extends ImageFilter
{
    void filter(int[] pixels, int w, int h)
    {
        for (int i=0; i<pixels.length; i++)
        {
            int c = pixels[i];

            int a = (c & 0xff000000) >> 24;
            int r = (c & 0x00ff0000) >> 16;
            int g = (c & 0x0000ff00) >> 8;
            int b = (c & 0x000000ff);

            int grey = (r + g + b)/3;

            pixels[i] = (a<<24) | (grey<<16) | (grey<<8) | grey;
        }
    }
}


class MirrorFilter extends ImageFilter
{
    void filter(int[] pixels, int w, int h)
    {
        for (int i=0; i<h; i++)
        for (int j=0; j<w/2; j++)
        {
            int n1 = i*w + j;
            int n2 = i*w + (w-j-1);

            int temp = pixels[n1];
            pixels[n1] = pixels[n2];
            pixels[n2] = temp;
        }
    }
}


void keyPressed()
{
    reloadImage();

    switch(key)
    {
        case 'r':
            redFilter.apply(apcs);
            break;

        case 'g':
            greenFilter.apply(apcs);
            break;

        case 'y':
            greyFilter.apply(apcs);
            break;

        case 'm':
            mirrorFilter.apply(apcs);
            break;
    }
}
