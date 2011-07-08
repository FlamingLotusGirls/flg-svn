
int oPurge = 2;
int oLiq = 3;
int iShoot = 9;
int iDelayPot = 5;

#define MINPURGE 500
#define MAXPURGE 2500
#define DEBOUNCEDELAY 50

unsigned long debounceTime = 0;
long delayTime;

void setup (){
  pinMode(iShoot, INPUT);
  pinMode(oPurge, OUTPUT);
  pinMode(oLiq, OUTPUT);
  digitalWrite(oPurge, LOW);
  digitalWrite(oLiq, LOW);
}

void loop(){
  if (digitalRead(iShoot) && (millis() > debounceTime)) {
    digitalWrite(oLiq, HIGH);
    debounceTime = millis() + DEBOUNCEDELAY;
    delayTime = ((analogRead(iDelayPot) * (MAXPURGE - MINPURGE)) / 1023) + MINPURGE;
    doShooter();
  }
}

void doShooter(){
  while (digitalRead(iShoot) || (millis() < debounceTime)) {
  }
  digitalWrite(oLiq, LOW);
  digitalWrite(oPurge, HIGH);
  delay (delayTime);
  digitalWrite(oPurge, LOW);  
}

  
  
