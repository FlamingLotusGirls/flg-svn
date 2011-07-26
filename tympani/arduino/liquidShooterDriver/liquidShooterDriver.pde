
int oPurge = 7;
int oLiq = 8;
int iShoot = 2;
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
  pinMode(3, HIGH);
  pinMode(4, HIGH);
  pinMode(5, HIGH);
  pinMode(6, HIGH);  
  digitalWrite(oPurge, LOW);
  digitalWrite(oLiq, LOW);
}

void loop(){
  if (digitalRead(iShoot) && (millis() > debounceTime)) {
    digitalWrite(oLiq, HIGH);
    debounceTime = millis() + DEBOUNCEDELAY;
    delayTime = map(analogRead(iDelayPot), 0, 1023, MINPURGE, MAXPURGE) ;
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

  
  
