//ESTELA

+flag (F)
  <-
  .wait(500);
  .register_service("capitan");
  .wait(3000);
  +peopleArrived(0);
  .get_service("equipo");
  .wait(500);
  +firstAngle;
  if(equipo(Q)){
    ?position(Pos);
    .print("¡Es que si hace falta me saco los pechos y los hipnotizo a todos, así, como quién no quiere la cosa, a lo Sabrina!");
    .send(Q, tell, goto(Pos));
    -equipo(Q);
  }.

+flag_taken: team(100) 
  <-
  .print("In ASL, TEAM_ALLIED flag_taken");
  ?base(B);
  +returning;
  .goto(B).

+estelaComeOnWeAreOnTrouble : not(finishedRealign)
  <-
  .print("¡Ay, mi Fernando, mi Fernando! ¡Qué mal lo pasé cuando me dejaste por aquella zorra de la esquina!");
  .addStrain(Res);
  //Si el strain devuelto es -1, se ha rebasado la tensión permitida
  if(Res == -1){
    .get_service("equipo1"); //Los que se retiran
    .get_service("equipo2");
    .wait(200);

    if(equipo2(L2)){
      .send(L2, tell, generate_package);
      .send(L2, tell, setAttack(1));
      -equipo2(L2);
    };
    .print("He ordenado generar paquetes");

    ?position(Pos);
    ?flag(F);

    if(equipo1(L1)){

      .send(L1, tell, lastMovement(Pos));
      .send(L2, tell, setAttack(0));
      +finishedRealign;
      -equipo1(L1);
      //.wait(4500);
      //+verticalColumn;
    };
    
  }
  .print(Res).

+verticalColumn
  <-
  .print("Vertical Columns");

  .get_service("equipo1");

  .wait(200);
  if(equipo1(L1)){
    .print("Calculando");

    ?position([X,Y,Z]);

    .length(L1, L1Length);
    .vColumn(X,Y,Z,L1Length, Res);
    
    if(L1Length >= 0){
    .nth(0, Res, Pos1);
    .nth(0, L1, Ag1);
    .send(Ag1, tell, lastMovement(Pos1));

    }

    if(L1Length >= 1){
    .nth(1, Res, Pos2);
    .nth(1, L1, Ag2);
    .send(Ag2, tell, lastMovement(Pos2));
    }

    if(L1Length >= 2){
    .nth(2, Res, Pos3);
    .nth(2, L1, Ag3);
    .send(Ag3, tell, lastMovement(Pos3));

    }

    if(L1Length >= 3){
    .nth(3, Res, Pos4);
    .nth(3, L1, Ag4);
    .send(Ag4, tell, lastMovement(Pos4));

    }
    -equipo1(L1);

  };
  .print("Vertical Columns finished").

+someoneHasArrived : not(goToFlag)
  <-
  ?peopleArrived(Q);
  H = Q+1;
  -peopleArrived(Q);
  +peopleArrived(H);

  if(H >= 9){
    ?flag(F);
    +goToFlag;
    .print("Oh, mi Fernando, con su cuerpecito contrahecho y su carita de pan lamiéndome mi pezón... ¡Qué recuerdos!");
    .get_service("equipo1");
    .wait(200);
    if(equipo1(E1)){
      .send(E1, tell, goto(F));
      -equipo1(E1);
    };
    .wait(5000);
    .get_service("equipo2");
    .wait(200);
    if(equipo2(E2)){
      .send(E2, tell, goto(F));
      -equipo2(E2);
    };
    .wait(5000);
    .goto(F);

  }.
  
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
  <- 
  if(not(friends_in_fov(ID,Type,Angle,Distance,Health,Position))){
    -friends_in_fov(ID,Type,Angle,Distance,Health,Position);
    .shoot(3,Position);
  }.

