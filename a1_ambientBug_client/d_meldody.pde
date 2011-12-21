int played = 0;

//PATTERN 1
  int cicada_length = 331; // the number of notes
  char cicada_notes[] = " 1212121212121212121212121211212   1212121212121212121212121211212  1212121212121212121212121211212  1212121212121212121212121211212 1212121212122121212121212122111  1212121212121212121212121211212   1212121212121212121212121211212  1212121212121212121212121211212  1212121212121212121212121211212 1212121212122121212121212122111 "; // a space represents a rest
  int cicada_beats[] = {1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
  1,2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
  1,2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,1};
  int cicada_tempo = 4;
  int cicada_repeat = 2;

//PATTERN 2
  int wasp_length = 156;
  char wasp_notes[] = "33334443333444444333344443333444433344443333  3333344444433334444333334444433444344  44433334444333334444433444344 3333444433333444443344434444434343433   ";
  int wasp_beats[] = {1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
  1,2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1};
  int wasp_tempo = 3;
  int wasp_repeat = 3;


void triggerSpeakerPattern(int i){
  
  if (i == 1){
      for (int i = 0; i < cicada_length * cicada_repeat && played==0; i++) {
        if (cicada_notes[i] == ' ') {
          delay(cicada_beats[i%cicada_length] * cicada_tempo); // rest
        } else {
          playNote(cicada_notes[i%cicada_length], cicada_beats[i%cicada_length] * cicada_tempo);
        }
    
        // pause between notes
        delay(cicada_tempo / 2); 
        
      }
    
  }
  if (i == 2){

      // play wasp sound
        for (int i = 0; i < wasp_length * wasp_repeat && played==0; i++) {
          if (wasp_notes[i] == ' ') {
            delay(wasp_beats[i%wasp_length] * wasp_tempo); // rest
          } else {
            playNote(wasp_notes[i%wasp_length], wasp_beats[i%wasp_length] * wasp_tempo);
          }
      
          // pause between notes
          delay(wasp_tempo / 2); 
    
        }
    
  }
}



void playTone(int tone, int duration) {
  for (long i = 0; i < duration * 1000L; i += tone * 2) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(tone);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(tone);
  }
}

void playNote(char note, int duration) {
  char names[] = {  '1', '2' , '3', '4' };
  int tones[] = {  175, 125, 75, 60 };

  // play the tone corresponding to the note name
  for (int i = 0; i < 4; i++) {
    if (names[i] == note) {
      playTone(tones[i], duration);
    }
  }
}
