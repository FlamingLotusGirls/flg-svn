
int oPurge = 7;
int oLiq = 8;
int oDammitBuffy = 9;
int iShoot = 2;
int iFountain = 3;
int iDammitBuffy = 4;
int iDelayPot = 5;

#define MINFOUNTPURGE 500 //min purge for fountain mode in ms
#define MAXFOUNTPURGE 6000 //max purge for fountain mode in ms

#define MINSHOOTPURGE 500 //min purge for shooter mode in ms
#define MAXSHOOTPURGE 3000 //min purge for shooter mode in ms

#define DEBOUNCEDELAY 50 // ms delay in responding to inputs
#define PURGEOFFTHRESHHOMLD 50 //input of the delay pot reads from 0 to 1023; this is the cutoff below which the purge is off

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
  pinMode(iDammitBuffy, INPUT);  
  pinMode(oPurge, OUTPUT);
  pinMode(oLiq, OUTPUT);
  pinMode(oDammitBuffy, OUTPUT);
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
        if (analogRead(iDelayPot) >= PURGEOFFTHRESHHOMLD){    
          purgeOffTime = millis() + map(analogRead(iDelayPot), PURGEOFFTHRESHHOMLD, 1023, MINFOUNTPURGE, MAXFOUNTPURGE);
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
        if (analogRead(iDelayPot) >= PURGEOFFTHRESHHOMLD){
          purgeOffTime = millis() + map(analogRead(iDelayPot), PURGEOFFTHRESHHOMLD, 1023, MINSHOOTPURGE, MAXSHOOTPURGE);
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
  if (digitalRead(iDammitBuffy)){
    digitalWrite (oDammitBuffy, HIGH);
  }
  else {
    digitalWrite (oDammitBuffy, LOW);
  }    
}

int isPressed (int input){ // debounces inputs and returns the state of the input after debouncing
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
  


  
  
