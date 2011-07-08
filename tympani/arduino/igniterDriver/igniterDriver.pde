
int iNormalOn = 3;
int iWetOn = 4;
int iOff = 2;
int oLED = 6;
int oRelay = 7;

volatile int okToRun = true;
unsigned long nextRelayTime;
unsigned long nextLedTime;
int i;
int j;
int relayState;
int ledState;
int blinkCount;

//*********************constants relating to the igniter on times
#define PROGRAMSTEPS 3 // how many stages are in the program specified by delayProgram
long delayProgram[PROGRAMSTEPS][3] = {  // program for wet start cycle, multiple stages of the pattern, each pattern goes like {time on(ms), time off(ms), repeat count}
                          {4, 500, 400},
                          {50, 500, 40},
                          {300, 500, 20}};
#define IGNITERONTIME 60000 // how long it stays on for once in the fully on mode
                                      
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
  pinMode(oRelay, OUTPUT);
  attachInterrupt(0, doShutOff, RISING);
  digitalWrite(oRelay, LOW);
  digitalWrite(oLED, LOW);
}

void loop (){
  if (digitalRead(iNormalOn)){
    okToRun = true;
    doNormalOn();
  }
  if (digitalRead(iWetOn)){
    okToRun = true;
    doWetOn();
  }
}

void doNormalOn(){// turn on for a fixed time, then turn off
  digitalWrite (oLED, HIGH);
  digitalWrite (oRelay, HIGH);
  nextRelayTime = millis() + IGNITERONTIME;
  while (millis()< nextRelayTime && okToRun){
    //hang out n wait
  }
  digitalWrite (oLED, LOW);
  digitalWrite (oRelay, LOW); 
}

void doWetOn (){// do the wet start cycle, then call doNormalOn
  relayState = LOW;
  ledState = LOW;
  nextLedTime = 0;
  nextRelayTime = 0;
  i=0;
  blinkCount = 0;
  while (i<PROGRAMSTEPS) {
    j=0;
    while (j<delayProgram[i][2] && okToRun){
      if (millis() > nextRelayTime){
        if (relayState) {
          relayState = LOW;
          nextRelayTime = millis() + delayProgram[i][1];
          j++;
        }
        else {
          relayState = HIGH;
          nextRelayTime = millis() + delayProgram[i][0];      
        }
        digitalWrite (oRelay, relayState);
      }
      if (millis() > nextLedTime){
        if (ledState){
          blinkCount++;
          if (blinkCount > getBlinks(i, j)){
            blinkCount = 0;
            nextLedTime = millis() + LEDLONGOFFTIME;
          }
          else {
            nextLedTime = millis() + LEDSHORTOFFTIME;
          }         
        }
        else {
          nextLedTime = millis() + LEDONTIME;
        }
        ledState = ledState?LOW:HIGH;
        digitalWrite (oLED, ledState);
      }
          
    }
    i++;
  }
  if (okToRun){
    doNormalOn();
  }
}


int getBlinks(int currentBigStep, int currentLittleStep){
  int totalSecondsLeft = 0;
  int blinks;
  int bigStep = PROGRAMSTEPS - 1;
  while (bigStep > currentBigStep){
    totalSecondsLeft += (delayProgram[bigStep][2]) * (delayProgram[bigStep][0] + delayProgram[bigStep][1]) / 1000;
    bigStep --;
  }
  totalSecondsLeft += (delayProgram[currentBigStep][2] - currentLittleStep) * (delayProgram[currentBigStep][0] + delayProgram[currentBigStep][1]) / 1000;
  blinks = (totalSecondsLeft + COUNTDOWNINTERVAL / 2) / COUNTDOWNINTERVAL;
  return blinks;
}


void doShutOff(){// called when the stop button is pressed
  digitalWrite (oLED, LOW);
  digitalWrite (oRelay, LOW);
  okToRun = false;// tell the other routines that might be inturrupted to just finish the loop and not turn on again
}

