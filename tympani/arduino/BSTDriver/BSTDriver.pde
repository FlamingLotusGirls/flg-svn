int oRelays[4] = {7, 8, 9, 10}; //relay outputs

int iAllSeq = 2; //input for all at once sequence
int iSeq [2] = {3, 4}; //inputs for other sequences
int iDelayPot = 5; // analog input for timing pontentiometer

int sequence = 0;
int i;
int onCycle = false;
int relayState[4];
int sequenceCounter = 0;
unsigned long nextEventTime = 0;


int sequences [2][4] = {{0, 1, 2, 3} , {0, 2, 1, 3}};// variable for storing the different relay sequence order
#define DUTYON 100 //duty on time in milliseconds
#define MINDUTYOFF 200 //min duty off time in milliseconds
#define MAXDUTYOFF 2500 //max duty off time in milliseconds



void setup (){
  pinMode (iAllSeq, INPUT);
  pinMode (iSeq [0], INPUT);
  pinMode (iSeq [1], INPUT); 
  for (i = 0; i < 4; i++){
    pinMode (oRelays[i], OUTPUT);
  }
}

void loop(){
  if (millis() > nextEventTime) {
    for (i = 0; i < 4; i++){//reset everything to off, then we'll turn on what we want to(if anything) for this step
      relayState[i] = LOW;
    }
    if (onCycle) {//we were in an on cycle, now go to an off cycle
      onCycle = false;
      nextEventTime = millis() + map(analogRead(iDelayPot), 0, 1023, MINDUTYOFF, MAXDUTYOFF);
    }
    else { // we were in an off cycle, now choose what relays to turn on
      if (digitalRead(iAllSeq)){// all at once mode selected
        for (i = 0; i < 4; i++){
          relayState[i] = HIGH;
        }
      }
      else {
        if (digitalRead (iSeq[0])){ //first sequential mode
          sequence = 0;
        }
        else { //second sequential mode
          sequence = 1;
        }
        relayState[sequences[sequence][sequenceCounter]] = HIGH;
        sequenceCounter = sequenceCounter >= 3?0:sequenceCounter + 1;

      }
      nextEventTime = millis() + DUTYON;
      onCycle = true;
    }
  }
  for (i = 0; i < 4; i++){
    digitalWrite(oRelays[i], relayState[i]);
  }
}
  


  
  
