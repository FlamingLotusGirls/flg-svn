
int oPurge = 7;
int oLiq = 8;
int oHorn = 9;
int iShoot = 2;
int iFountain = 3;
int iHorn = 4;
int iDelayPot = 5;

#define MINFOUNTPURGE 500
#define MAXFOUNTPURGE 6000
#define MINSHOOTPURGE 500
#define MAXSHOOTPURGE 3000
#define DEBOUNCEDELAY 50

unsigned long deBounceTimeOut[4];
unsigned long purgeOffTime = 0;

int liqState = LOW;
int purgeState = LOW;
int mode = 0;
int deBounceWait[4];
int lastState[4];

void setup (){
  pinMode(iShoot, INPUT);
  pinMode(iFountain, INPUT);
  pinMode(iHorn, INPUT);  
  pinMode(oPurge, OUTPUT);
  pinMode(oLiq, OUTPUT);
  pinMode(oHorn, OUTPUT);
  digitalWrite(oPurge, LOW);
  digitalWrite(oLiq, LOW);
  for (int i=0; i<4; i++){
    deBounceTimeOut[i] = 0;
    deBounceWait[i] = false;
    lastState[i] = LOW;
  }
}

void loop(){
  switch(mode){
    case 0: //nothing happening
      liqState = LOW;
      purgeState = LOW;
      if (isPressed(iFountain)){
        mode = 1;
      }
      if (isPressed(iShoot)){
        mode = 2;
      }
      break;  
    case 1: //fountain
      liqState = HIGH;
      purgeState = LOW;
      if (!isPressed(iFountain)){
        if (analogRead(iDelayPot) >= 50){    
          purgeOffTime = millis() + map(analogRead(iDelayPot), 50, 1023, MINFOUNTPURGE, MAXFOUNTPURGE);
          mode = 3;
        }
        else {
          mode = 0;
        }
      }
      break;
    case 2: //liquid shooter
      liqState = HIGH;
      purgeState = LOW;
      if (!isPressed(iShoot)){
        if (analogRead(iDelayPot) >= 50){
          purgeOffTime = millis() + map(analogRead(iDelayPot), 50, 1023, MINSHOOTPURGE, MAXSHOOTPURGE);
          mode = 3;
        }
        else {
          mode = 0;
        }
      }
      break;
    case 3: // purge
      liqState = LOW;
      purgeState = HIGH;
      if (millis() > purgeOffTime){
        mode = 0;
      }  
      break;
  }
  digitalWrite (oPurge, purgeState);
  digitalWrite (oLiq, liqState);
  if (digitalRead(iHorn)){
    digitalWrite (oHorn, HIGH);
  }
  else {
    digitalWrite (oHorn, LOW);
  }    
}

int isPressed (int input){
  int currentState = digitalRead(input);
  if (deBounceWait[input]){
    if (currentState == lastState[input]){
      deBounceWait[input] = false;
    }
    else if (millis() > deBounceTimeOut[input]){
      deBounceWait[input] = false;
      lastState[input] = currentState;
    }
  }
  else if (currentState != lastState[input]){
    deBounceWait[input] = true;
    deBounceTimeOut[input] = millis() + DEBOUNCEDELAY;
  }
  return lastState[input];
}
  


  
  
