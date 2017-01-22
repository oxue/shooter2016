# Shooter Game

This is the bleeding edge version of the engine. You can find a demo hosted [here](http://csclub.uwaterloo.ca/~y267xu/html5/index.html)

You may notice another repository on my account, namely [shooter2016.5](https://github.com/oxue/shooter2016.5). That is the version before I made huge changes the the rendering codebase to port the game to kha. The port made the game compilable for android and web platforms at a higher performance.

The khashooter repository contains the entrypoint for compiling this engine, this repo contains the juicy libraries that is used, hence I didn't pin the [khashooter project](https://github.com/oxue/khashooter) 

You can move the character with the WASD keys and right click to show the debug menu. The lighting engine use built using geometry calculated on the shaders so it should be pretty fast. The enemy AI uses a simple breadcrumbs algorithm right now. The art is done by me.

The debug menu currently has the features to teleport, spawn a light source of random color, spawn an enemy, or change the ambient lighting level.
