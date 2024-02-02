class Player extends Sprite {
    boolean left, right, up, down;
    boolean isFiring = false;

    Player(float x, float y) {
        super(x, y, 40, 40);
        team = 1;
    }

    @Override
    void update() {
        float speed = 1.2;
        if (left)  vel.add(new PVector( -speed, 0));
        if (right) vel.add(new PVector(speed, 0));
        if (up)    vel.add(new PVector(0, -speed));
        if (down)  vel.add(new PVector(0, speed));

        // Update position by velocity
        pos.add(vel);

        // Fix bounds
        if(pos.x < 0 + size.x/2) pos.x = size.x/2;
        if(pos.x > width - size.x/2) pos.x = width - size.x/2;
        if(pos.y < 0 + size.y/2) pos.y = size.y/2;
        if(pos.y > height - size.y/2) pos.y = height-size.y/2;

        // Always try to decelerate
        vel.mult(0.9);
    }

    @Override
    void display() {
        fill(200, 0, 200);
        rect(pos.x, pos.y, size.x, size.y);
    }

    @Override
    void handleCollision() {
        // Don't die.
    }

    // Handle space bar key press to toggle firing
    void keyPressed() {
        switch(key) {
            case 'a':
            case 'A': left = true; break;
            case 's':
            case 'S': down = true; break;
            case 'd':
            case 'D': right = true; break;
            case 'w':
            case 'W': up = true; break;
            case ' ':
                isFiring = true; // Set the flag when space bar is pressed
                break;
        }
    }

    // Handle space bar key release to stop firing
    void keyReleased() {
        switch(key) {
            case 'a':
            case 'A': left = false; break;
            case 's':
            case 'S': down = false; break;
            case 'd':
            case 'D': right = false; break;
            case 'w':
            case 'W': up = false; break;
            case ' ':
                isFiring = false; // Unset the flag when space bar is released
                break;
        }
    }

    void fire() {
        if (isFiring) {
            PVector aim = new PVector(0, -10); // Upwards direction
            _SM.spawn(new Bullet(pos.x, pos.y, aim, team));
        }
    }
}
