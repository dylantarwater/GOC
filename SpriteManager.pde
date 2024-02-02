class SpriteManager {
    Player player;
    int shootersKilled = 0;
    long lastShooterSpawnTime;

    
    ArrayList<Sprite> active = new ArrayList<Sprite>();
    ArrayList<Sprite> destroyed = new ArrayList<Sprite>();
    
    SpriteManager() {
        player = new Player(width / 2, height - 100);
        spawn(player);
        lastShooterSpawnTime = millis(); // Initialize lastShooterSpawnTime
    }

    
    void destroy(Sprite target) {
        destroyed.add(target);
        if (target instanceof Shooter) {
            shootersKilled++;
        }
    }

    
    void spawn(Sprite obj) {
        active.add(obj);
    }
    
    void manage() {
        moveEverything();
        checkCollisions();    
        bringOutTheDead();
        drawEverything();
        
        // Check if it's time to spawn a new shooter
        if (millis() - lastShooterSpawnTime > 5000 && shootersKilled > 0) {
            spawnShooter();
            lastShooterSpawnTime = millis();
            shootersKilled--;
        }
    }

    void spawnShooter() {
        _SM.spawn(new Shooter(random(width), random(height)));
    }


    
    void moveEverything() {
        for(int i = active.size() - 1; i >= 0; i--) {
            active.get(i).update();           
        }
    }
    
    void drawEverything() {
        for (Sprite s : active)
            s.display();
    }
    
    void checkCollisions() {
        for (int i = 0; i < active.size(); i++) {
            for (int j = i + 1; j < active.size(); j++) {
                Sprite a = active.get(i);
                Sprite b = active.get(j);
                if (a.team != b.team && collision(a, b)) {
                    active.get(i).handleCollision();
                    active.get(j).handleCollision();
                }
            }
        }
    }
    
    void bringOutTheDead() {
        for (int i = 0; i < destroyed.size(); i++) {
            Sprite target = destroyed.get(i);
            active.remove(target);
            destroyed.remove(target);
        }
    }
    
    boolean collision(Sprite a, Sprite b) {
        // Rectangular collision detection
        return (a.pos.x < b.pos.x + b.size.x &&
                a.pos.x + a.size.x > b.pos.x &&
                a.pos.y < b.pos.y + b.size.y &&
                a.pos.y + a.size.y > b.pos.y);
    }

}