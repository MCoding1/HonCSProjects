class Particle
{
    PVector position;
    PVector velocity;
    int c;
    int r = 2;

    Particle(PVector position, PVector velocity)
    {
        this.position = position.copy();
        this.velocity = velocity.copy();
        c = color(random(255), random(255), random(255));
    }

    void draw()
    {
        fill(c);
        ellipse(position.x, position.y, 2*r, 2*r);

        position.add(velocity);
    }
}
