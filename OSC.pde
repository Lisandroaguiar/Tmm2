import oscP5.*; 
import netP5.*; // librería para envio de mensajes
boolean recibirMensaje = false; // vaiable buleana para recibir mensajes nuevos

OscP5 osc;
NetAddress myRemoteLocation;

OscProperties propiedadesOSC;

ArrayList <OscMessage> mensajes;

void setupOSC( int puertoIn, int puertoOut, String ip) {

  // in
  propiedadesOSC = new OscProperties();

  propiedadesOSC.setDatagramSize(10000);
  propiedadesOSC.setListeningPort(puertoIn);
  osc = new OscP5(this, propiedadesOSC);

  mensajes = new ArrayList<OscMessage>();
  
  // out
  myRemoteLocation = new NetAddress(ip, puertoOut);
}

void oscEvent (OscMessage m) {

   if (recibirMensaje) {
    mensajes.add(m);
  }
}
