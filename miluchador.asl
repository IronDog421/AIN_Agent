//EJEMPLO LUCHADOR 

+flag(F): team(200)
  <-

  //MOVEMENT SYSTEM
  M = [130, 0, 115];
  .goto(M);

  //BATTLE SYSTEM
  +notDuelling;

  //ROTATION SYSTEM
  +halfRotationVar; 
  +halfRotateFunc.

  //PERCEPTION SYSTEM
  +periodicPerception.


+periodicPerception
  <- 
  //TODO
  .wait(500);
  +periodicPerception.

+target_reached(T)
  <-
  .print("Got control points:", C);

  //STOP HALF ROTATION
  -halfRotationVar; 
  -halfRotateFunc;

  //START FULL ROTATION
  +fullRotationVar;
  +fullRotateFunc.
  

+friends_in_fov(ID,Type,Angle,Distance,Health,Position)
  <-
  -notDuelling;
  .shoot(3,Position).

+packs_in_fov(ID, TYPE, ANGLE, DIST, HEALTH, [X,Y,Z]) : notDuelling
  <-
  //Check the health of the user, if is lower than 40, then go to the pack
  if(ID==1001){
    ?health(H);
      if(H < 40){
      .print("Health is lower than 40, going to pack");
      .goto([X,Y,Z]);
      }else{
        .print("Health is higher than 40, not going to pack");
      };
    };
  if(ID==1002){
    ?ammo(A);
      if(A < 50){
      .print("Ammo is lower than 50, going to pack");
      .goto([X,Y,Z]);
      }else{
        .print("Ammo is higher than 50, not going to pack");
      };
    }.  

// Acción para rotar el agente cada 1 segundo
+halfRotateFunc: halfRotationVar
<- 
.turn(0.8); // Gira el agente 0.1 radianes
.wait(100); // Espera 1000 milisegundos (1 segundo)
.turn(-0.8); // Gira el agente 0.1 radianes
.wait(100); // Espera 1000 milisegundos (1 segundo)
-+halfRotateFunc.

+fullRotateFunc: fullRotationVar
<- 
.turn(0.8); // Gira el agente 0.1 radianes
.wait(100); // Espera 1000 milisegundos (1 segundo)
-+fullRotateFunc.

