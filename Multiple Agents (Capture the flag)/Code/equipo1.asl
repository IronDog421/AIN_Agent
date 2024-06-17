/////////////////////////
//*CLASE DE INFANTERIA*//
/////////////////////////

//////////////////////////////////////
//*Por Carlos Ruiz y Andres Pacheco*//
//////////////////////////////////////

+flag (F)
  <-
  ///////////////////////////
  //*Registro de servicios*//
  ///////////////////////////

  .register_service("infanteria");
  .get_service("capitan");
  .wait(300);
  +periodicPerception.

+goto(Pos)
  <-
  .goto(Pos).

+setBurst(Burst)
  <-
  +burst(Burst).

+updateBurst(Burst)
  <-
  ?burst(AuxBurst);
  -burst(AuxBurst);
  +burst(Burst).

+flag_taken: team(100) 
  <-
  //////////////////////
  //*Plan de retirada*//
  //////////////////////
  
  .print("In ASL, TEAM_ALLIED flag_taken");
  ?base(B);
  +returning;
  .goto(B);

  .get_service("capitan");
  .get_service("infanteria");
  .wait(500);
  if(capitan(C)){
      .send(C, tell, goto(B));
  };

  if(infanteria(I)){
    .send(I, tell, goto(B));
  }.

+target_reached(T): team(100)
  <- 
  ///////////////////////////
  //*Aviso de reagrupación*//
  ///////////////////////////

  .get_service("capitan");
  .wait(500);
  if(capitan(C)){
    .send(C, tell, someoneHasArrived);
  }.

+periodicPerception
  <-
  ///////////////////////////
  //*Sistema de percepción*//
  ///////////////////////////

  ?ammo(A);

  if(A <= 80 & not(strained)){
    .get_service("capitan");
    .wait(500);
    if(capitan(C)){
        .send(C, tell, moreStrain);
        +strained;
      };
  };

  .wait(500);

  -+periodicPerception.
  
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
  <- 
  /////////////////////
  //*Modo de disparo*//
  /////////////////////
  ?burst(B);

  if(burst(B)){
    .shoot(B,Position);
  } else{
    .shoot(3,Position);
  }.

