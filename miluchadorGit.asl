//EJEMPLO LUCHADOR 

+flag(F): team(200)
  <-

  //INITIAL MOVEMENT
  M = [130, 0, 115];
  .goto(M);

  //INITIAL BEHAVIOUR
  +firstPhase;

  //ONE USE VAR TO AVOID OVERLOAD
  +oneUseVar;

  //PERCEPTION SYSTEM
  +periodicPerception.

+periodicPerception: true
  <-
  

  // CHECK IF THE AMMO HAS DECREASED
  ?ammo(Ammo);
  .wait(1000);
  ?ammo(NewAmmo);
  if (NewAmmo < Ammo) {
    +stopMovement;
    +oneUseVar;
    -decidedPack;
    -firstPhase;
  } else {



    ?health(Health);

    if(Health >= 90 & NewAmmo >= 90){
      -wantPack;
    };
      

    // NEED HEALTH? -> NEEDHEALTH = TRUE
    if(not(needHealth)){
        ?health(H);
      if(H < 90){
        .print("I need health!");
        +wantPack;
        +needHealth;
      }
    };

    // NEED AMMO? -> NEEDAMMO = TRUE
    if(not(needAmmo)){
        ?ammo(A);
      if(A < 90){
        .print("I need ammo!");
        +wantPack;
        +needAmmo;
      }
    };

    if(oneUseVar & not(decidedPack)){
      +continueMovement;
      -oneUseVar;
    };
    

    
    if(firstPhase){
    +startHalfRotation; 
      }else{
        if(wantPack & not(decidedPack)){
          +startFullRotation;
        }else{
          if(decidedPack){
            .print("Me muevo de forma recta hacia el pack!");
          
        } else {
          +startFullRotation;
        };
        }
        
    };
  };

  -+periodicPerception.

/////MOVEMENT BEHAVIOUR/////
+stopMovement: true
  <-
  .stop.

+continueMovement: true
  <-
  //-decidedPack;

  .print("Hacia el centro");
  ?position(Position);
  Center = [130, 0, 115];
  if(not(Position == Center)){
    
    M = [130, 0, 115];
    .goto(M);
    +firstPhase;
  } else {
    .print("Quería ir al centro pero ya estoy en el centro!"); 
  }.



  


/////ROTATION BEHAVIOUR/////
+stopRotation: true
  <-
  -halfRotationVar; 
  -halfRotateFunc;
  -fullRotationVar;
  -fullRotateFunc.

+startHalfRotation: true
  <-
  +halfRotationVar; 
  +halfRotateFunc.

+startFullRotation: true
  <-
  +fullRotationVar; 
  +fullRotateFunc.

/////OBJECTIVES/////
+target_reached(T)
  <-
  .print("He llegado a donde quería ir", C);
  -firstPhase;

  if(decidedPack){
    -decidedPack;
    -needAmmo;
    -needHealth;
    
    
  };
  +oneUseVar.


+pack_taken(TYPE, N)
  <-
  .print("He obtenido:", TYPE, "con cantidad:", N);
  -decidedPack;
  -wantPack;
   
  -needAmmo;
  -needHealth.

  //if(TYPE==1002){
  //    -needAmmo;
  //}else{
  //    -needHealth;
  //}.
  
  
/////FOV/////
+friends_in_fov(ID,Type,Angle,Distance,Health,Position)
  <-
  .shoot(3,Position).

+packs_in_fov(ID, TYPE, ANGLE, DIST, HEALTH, [X,Y,Z]): wantPack & not(decidedPack)
  <-
  //CONTROLAR PARA IR A POR EL PRIMER PACK
  .print("Veo un paquete");

  if(TYPE==1002 & needAmmo){
      .print("Decido ir a por el pack de munición!");
      
      +decidedPack;
      .goto([X,Y,Z]);
  };

  if(TYPE==1001 & needHealth){
    .print("Decido ir a por el pack de salud!");
    +decidedPack;
    .goto([X,Y,Z]);
    
  }.

/////ROTATION FUNCTIONS/////
+halfRotateFunc: halfRotationVar
<- 
.turn(0.8); // Gira el agente 0.1 radianes
.wait(100); // Espera 1000 milisegundos (1 segundo)
.turn(-0.8); // Gira el agente 0.1 radianes
.wait(100); // Espera 1000 milisegundos (1 segundo)
-halfRotateFunc.

+fullRotateFunc: fullRotationVar
<- 
.turn(1.571); // Gira el agente 0.1 radianes
.wait(100); // Espera 1000 milisegundos (1 segundo)
-fullRotateFunc.

