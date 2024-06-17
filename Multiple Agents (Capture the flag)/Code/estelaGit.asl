////////////////////////////////
//*CLASE DE CAPITAN LOGISTICO*//
////////////////////////////////

//////////////////////////////////////
//*Por Carlos Ruiz y Andres Pacheco*//
//////////////////////////////////////

+flag (F)
  <-
  ///////////////////////////
  //*Registro de servicios*//
  ///////////////////////////

  .register_service("capitan");
  .wait(500);
  +peopleArrived(0);
  .wait(1000);
  .get_service("infanteria");
  .wait(500);
  .getBurst(Burst);
  .wait(500);

  ////////////////////////////
  //*Inicio de reagrupación*//
  ////////////////////////////

  if(infanteria(I)){
    ?position(Pos);
    .print("Todos conmigo!");
    .send(I, tell, setBurst(Burst));
    .send(I, tell, goto(Pos));
    -infanteria(I);
  }.

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

+moreStrain : not(strained)
  <-
  ////////////////////////////////
  //*Sistema de tensión militar*//
  ////////////////////////////////

  //////////////////////////////////////////////////////////////
  //*1. Aumentar la tensión por demanda de las tropas aliadas*//
  //////////////////////////////////////////////////////////////
  .addStrain(Res);

  /////////////////////////////////////////////////////////////////////////
  //*2. Si se supera la tensión del umbral, reducir las balas por ráfaga*//
  /////////////////////////////////////////////////////////////////////////
  if(Res == 0){
    .getBurst(Burst);
    +strained;
    .print("Tensión en el equipo. Disminuimos la cantidad de balas por ráfaga para evitar el desperdicio.");

    .get_service("infanteria");

    .wait(500);
    if(infanteria(I)){
      .send(I, tell, updateBurst(Burst));
    };
  }.

+someoneHasArrived : not(firstRegroup)
  <-
  ////////////////////////////////////
  //*Sistema de redirección*//
  ////////////////////////////////////

  ///////////////////////////////////////////////////
  //*1. Esperar a la reagrupación total del equipo*//
  ///////////////////////////////////////////////////

  ?peopleArrived(Q);
  H = Q+1;
  .print("Somos",H+1,"tropas.");
  -peopleArrived(Q);
  +peopleArrived(H);

  ////////////////////////////////////////////
  //*2. Iniciar la marcha hacia el objetivo*//
  ////////////////////////////////////////////

  if(H >= 9){
    ?flag(F);
    +firstRegroup;

    .get_service("infanteria");
    .wait(200);
    if(infanteria(I)){
      .send(I, tell, goto(F));
      -equipo1(I);
    };
    
    .goto(F);
    .print("En marcha!");
  }.
  
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
  <- 
  /////////////////////
  //*Modo de disparo*//
  /////////////////////

  .shoot(2,Position).

+goto(Pos)
  <-
  .goto(Pos).

