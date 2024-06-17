//TEAM_ALLIED 

+flag (F)
  <-
  .wait(1000);
  .register_service("equipo");
  .wait(500);
  .register_service("equipo1");
  +criticalSystem;
  +canAttack;
  
  .get_service("capitan");
  
  .wait(200);
  +periodicPerception.


///////////////////////////
//*SISTEMA DE PERCEPCIÓN*//
///////////////////////////
+periodicPerception
  <-
  ?ammo(Ammo);
  ?health(Health);

  /////////////////////////////////
  //*SOLICITAR SEGUNDA FORMACIÓN*//
  /////////////////////////////////
  if((Health < 50 | Ammo <10)){
    -criticalSystem;
    .get_service("capitan");
    if(capitan(C)){
      .send(C, tell, estelaComeOnWeAreOnTrouble);
    }
    
  }

  .wait(500);
  -+periodicPerception.


+lonely
  <-
  +lonely.

+goto(Pos)
  <-
  .print("Recibido un mensaje de tipo ir_a de para ir a: ", Pos);
  .goto(Pos).

+setAttack(Value)
  <-
  .wait(1000);
  if(Value==1){
    +canAttack;
  } else{
    -canAttack;
    .wait(3000);
    +canAttack;
  }.

+lastMovement(Pos)
  <-
  .print("PACA PACHECOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
  .goto(Pos);
  .wait(5000);
  ?flag(F2);
  .goto(F2).

+flag_taken: team(100) 
  <-
  .print("In ASL, TEAM_ALLIED flag_taken");
  ?base(B);
  +returning;
  .goto(B).

+target_reached(T): team(100)
  <- 
    if(capitan(C)){
      .send(C, tell, someoneHasArrived);
    };
    if(lonely){
      ?flag(F);
      .goto(F);
    }.
  
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position) : canAttack
  <- 
    .shoot(3,Position).
