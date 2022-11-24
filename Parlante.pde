class Parlante {
  FCircle[] notas;
  float x, y;
  float ancho = 70;
  float alto =70;
  float velocidad = 300;
  float anguloVel = 2;
  float angulo;
  PImage[] nota;
  int PUERTO_IN_OSC = 12345;
  int PUERTO_OUT_OSC = 12346;
  String IP = "127.0.0.1";
int dibujarCirculo=0;
  Receptor receptor;
int queImagen;
  Emisor emisor;

int id;

  PuntoLocal[] p;
  Parlante( float x_, float y_ ) {
    x=x_;
    y= y_;
    
    angulo = radians (40);
    notas = new FCircle[10];
    setupOSC(PUERTO_IN_OSC, PUERTO_OUT_OSC, IP);
    //p = new PuntoLocal(id, notas.getX(), notas.getY());
    p= new PuntoLocal[10];
    emisor = new Emisor();
         receptor = new Receptor();
         nota=new PImage[11];
    for(int i=0; i<p.length; i++){
      notas[i] = new FCircle(90);
      p[i] = new PuntoLocal(i, notas[i].getX(), notas[i].getY());

    }
    
           receptor.setPuntosLocales(emisor.puntosLocales);

   
  }
  void crearNota(int i)
{ 
  
  mundo.add(notas[i]);
  emisor.addPunto(p[i]);


     notas[i].setPosition(300,400);
}

  void dibujar () {
    pushMatrix();
   
    
    

    //rect(x, y, ancho, alto);
    popMatrix();
  }

  void dibujarNotas( FWorld mundo) {
     for(int i=1; i<11; i++){
    nota[i] = loadImage("imagenes/nota" + i + ".png");}
      if(numeroDeFragmento==0){
      queImagen=1;}
    if(numeroDeFragmento==1){
      queImagen=2;}
      if(numeroDeFragmento==2){
      queImagen=3;}
      if(numeroDeFragmento==3){
      queImagen=4;}
      if(numeroDeFragmento==4){
      queImagen=5;}
      if(numeroDeFragmento==5){
      queImagen=6;}
      if(numeroDeFragmento==6){
      queImagen=7;}
      if(numeroDeFragmento==7){
      queImagen=8;}
      if(numeroDeFragmento==8){
      queImagen=9;}
      if(numeroDeFragmento==9){
      queImagen=10;}

    float vx = velocidad * cos  (angulo) ;
    float vy = velocidad * sin (angulo);
for(int i=0; i<p.length; i++){
   
    //notas[i].setGrabbable(true);
    notas[i].setVelocity (vx, vy);

    //para despues detectar las coliciones
    notas[i].setName("notas");
    notas[i].setDensity(0.03);
   notas[i].attachImage(nota[queImagen]);

    
  
    //if((notas[i].getX()<50 && notas[i].getY()<10)||(notas[i].getX()>width && notas[i].getY()>height)){
    //  mundo.add(notas[i]);
    
    
    //}
}
 dibujarCirculo++;
  }
  
   
    
  

  void oportunidades(SoundFile audio) {
    ArrayList <FBody> cuerpos = mundo.getBodies();

    for (FBody este : cuerpos) {
      String nombre = este.getName();
      if (nombre != null && nombre.equals("notas") && este.getY() > height) {
       
          if(opo > 0){
            opo--;
            
          }
            mundo.remove(este);
            audio.play();
            
        
      }
    }
  }
  void mover() {
    receptor.actualizar(mensajes);
   // receptor.dibujarZonasRemotas(width, height);
    for(int i=0; i<p.length; i++){
      float x=constrain(notas[i].getX(),0, width);
  float y=constrain(notas[i].getY(),0, height);
    p[i].actualizarPosicion(x, y);

    notas[i].addImpulse(p[i].getMovX(), p[i].getMovY() );

    p[i].actualizarPosicion(x, y); // mi punto local actualiza su posición en funciób del FCircle c

    notas[i].addImpulse(p[i].getMovX()*200, p[i].getMovY() *200); // le doy un impulso al FCircle c en la dirección de movimiento del punto p
    }
    emisor.actualizar();
    //emisor.dibujar();
  }
}
