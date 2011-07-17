
#define NUMOUTPUTS 4


int iNormalOn = 3;
int iWetOn = 4;
int iOff = 2;
int oLED = 6;
int oRelay[NUMOUTPUTS] = {7, 8, 9, 10};


volatile int okToRun = false;
unsigned long nextRelayOnTime[NUMOUTPUTS];
unsigned long nextRelayOffTime[NUMOUTPUTS];
unsigned long programStepFinishTime[NUMOUTPUTS];
int currentProgramStep[NUMOUTPUTS];
int i;
int ledState;
int ledBlinkCount;
unsigned long nextLedEventTime;
int lastStep = NUMOUTPUTS - 1;


//*********************constants relating to the igniter on times
#define PROGRAMSTEPS 3 // how many stages are in the program specified by delayProgram
long delayProgram[PROGRAMSTEPS][3] = {  // program for wet start cycle, multiple stages of the pattern, each pattern goes like {time on(ms), total on-off cycle duration(ms), total time of stage(ms)}
                          {4, 500, 200000},
                          {50, 500, 20000},
                          {150, 500, 16000}};
#define NORMALONSTAGGER 3000 // stagger the start times this many ms to even out the power use
#define WETONSTAGGER 18060 // wet cycle stagger, this number is so that the last stages and the first fre seconds of on time don't conincide and the pulses before that are staggered

//*********************constants for LED blinks n crap
#define COUNTDOWNINTERVAL 30 // on the LED blink countdown, this is the interval length. so if it's 15, one blink = 15 seconds left
#define LEDONTIME 150
#define LEDSHORTOFFTIME 150
#define LEDLONGOFFTIME 1000

void setup (){
  pinMode(iNormalOn, INPUT);
  pinMode(iWetOn, INPUT);
  pinMode(iOff, INPUT);
  pinMode(oLED, OUTPUT);
  attachInterrupt(0, doShutOff, RISING);
  digitalWrite(oLED, LOW);
  for (i=0; i < NUMOUTPUTS; i++){
    pinMode(oRelay[i], OUTPUT);
    digitalWrite(oRelay[i], LOW);
    nextRelayOffTime[i] = 0;
    nextRelayOnTime[i] = 0;
  }
}

void loop (){
  if (digitalRead(iNormalOn)){
    okToRun = true;
    resetLEDs();
    doNormalOn();
  }
  if (digitalRead(iWetOn)){
    okToRun = true;
    resetLEDs();
    doWetOn();
  }
  while (okToRun){
     //after doNormalOn or doWetOn has run, stay here and keep the igniters on until the stop button calls the interrupt
  }
}

void doNormalOn(){// turn on for a fixed time, then turn off
  for (i=0; i < NUMOUTPUTS; i++){
    nextRelayOffTime[i] = 4294967295; //set the offtime to the maximum allowed by a long int so we stay on
    nextRelayOnTime[i] = millis() + i * NORMALONSTAGGER;
  }
  while (okToRun && processRelayEvents()){
    blinkLED(1);
  }
  digitalWrite(oLED, HIGH);
}



void doWetOn (){// do the wet start cycle
  unsigned long currentTime = millis();
  unsigned long secondsLeft;
  unsigned long estEndTime = currentTime + NUMOUTPUTS * WETONSTAGGER;
  for (i=0; i < PROGRAMSTEPS; i++) {
    estEndTime += delayProgram[i][2];
  }
  for (i=0; i < NUMOUTPUTS; i++){
    programStepFinishTime[i] = currentTime + i * WETONSTAGGER;
    nextRelayOnTime[i] = programStepFinishTime[i];
    nextRelayOffTime[i] = programStepFinishTime[i] + delayProgram[0][0];
    currentProgramStep[i] = -1;
  }
  while (okToRun && processRelayEvents()){
    currentTime = millis();
    for (i=0; i < NUMOUTPUTS; i++){
      if (programStepFinishTime[i] <= currentTime){ //is it time to move to the next stage in the cycle for this relay?
        currentProgramStep[i] ++;
        if (currentProgramStep[i] >= PROGRAMSTEPS){//this relay is ready to go to full on mode
          nextRelayOnTime[i] = currentTime;
          nextRelayOffTime[i] = 4294967295; //set the offtime to the maximum allowed by a long int so we stay on
        }
        else {
          programStepFinishTime[i] += delayProgram[currentProgramStep[i]][2];
        }
        if (i == lastStep) {// if we moved to the next stage on the last igniter, re-estimate the time left for the LED blinks. Tried to make it just estimate once at the beginning but it just wouldn't fing work right, so had to go to this
          estEndTime = currentTime;
          for (i = currentProgramStep[i]; i < PROGRAMSTEPS; i++) {
            estEndTime += delayProgram[i][2];
          }
        }
      }
      if (currentProgramStep[i] > -1 && currentProgramStep[i] < PROGRAMSTEPS){// are we within an actual stage in the program? -1 means waiting to start, and more than the number of program steps means steady on mode
        if (currentTime > (nextRelayOffTime[i] + 10)){
          nextRelayOnTime[i] +=  delayProgram[currentProgramStep[i]][1];
          nextRelayOffTime[i] = nextRelayOnTime[i] + delayProgram[currentProgramStep[i]][0];
        }
      }
    }
    if (millis() > nextLedEventTime) {// time to turn the led on or off?
      secondsLeft = (estEndTime - currentTime) / 1000 + COUNTDOWNINTERVAL;
      blinkLED (secondsLeft/COUNTDOWNINTERVAL );
    }
  }
  if (okToRun){
    digitalWrite(oLED, HIGH);
  }
}


void blinkLED(int numBlinks){ // take the number of blinks we want and handle the LED
    if (millis() > nextLedEventTime) {
     if (ledState) {
       ledState = LOW;
       ledBlinkCount--;
       if (ledBlinkCount > 0){
         nextLedEventTime = millis() + LEDSHORTOFFTIME;
       }
       else{
         ledBlinkCount = numBlinks;
         nextLedEventTime = millis() + LEDLONGOFFTIME;
       }
     }
     else{
       ledState = HIGH;
       nextLedEventTime = millis() + LEDONTIME;
     }
   }
   if (okToRun) {
     digitalWrite (oLED, ledState);
   }
}

int processRelayEvents(){ //see if it's time to turn a relay off or on, and if all of them are in steady on mode, return false
  int keepGoing = false;
  for (i=0; i < NUMOUTPUTS; i++){
    if (nextRelayOnTime[i] <= millis() && nextRelayOffTime[i] > millis()){
      if (okToRun){
        digitalWrite (oRelay[i], HIGH);
      }
      if (nextRelayOffTime[i] < 4294967295) {
        keepGoing = true;
      }
    }
    else {
      if (nextRelayOffTime[i] < millis()){
        digitalWrite (oRelay[i], LOW);
      }   
      keepGoing = true;
    }
  }
  return keepGoing;
}

void doShutOff(){// called when the stop button is pressed, turn everything off and reset the variables we need to
  digitalWrite (oLED, LOW);
  for (i=0; i < NUMOUTPUTS; i++){
    digitalWrite(oRelay[i], LOW);
    nextRelayOffTime[i] = 0;
    nextRelayOnTime[i] = 0;    
  }
  okToRun = false;// tell the other routines that might be inturrupted to just finish the loop and not turn on again
}

void resetLEDs(){// imagine the horror we get the wrong number of blinks!
  ledState = HIGH;
  ledBlinkCount = 0;
}

