#include "relay_map.h"

/* relay mappings */
prog_uint8_t relay_data[] = {
  /* relay     unit  addr */

  /* pod 1 */
  /*  0 */     0x1,  0x1,  /* RL Enable */
  /*  1 */     0x1,  0x2,  /* RL Dir */
  /*  2 */     0x1,  0x3,  /* UD Enable */
  /*  3 */     0x1,  0x4,  /* UD Dir */
  /*  4 */     0x1,  0x5,  /* Fire */
  /*  5 */     0x1,  0x6,  /* Purge */
  /*  6 */     0x1,  0x7,
  /*  7 */     0x1,  0x8,

  /* pod 2 */
  /*  8 */     0x2,  0x1,  /* RL Enable */
  /*  9 */     0x2,  0x2,  /* RL Dir */
  /* 10 */     0x2,  0x3,  /* UD Enable */
  /* 11 */     0x2,  0x4,  /* UD Dir */
  /* 12 */     0x2,  0x5,  /* Fire */
  /* 13 */     0x2,  0x6,  /* Purge */
  /* 14 */     0x2,  0x7,
  /* 15 */     0x2,  0x8,

  /* pod 3 */
  /* 16 */     0x3,  0x1,  /* RL Enable */
  /* 17 */     0x3,  0x2,  /* RL Dir */
  /* 18 */     0x3,  0x3,  /* UD Enable */
  /* 19 */     0x3,  0x4,  /* UD Dir */
  /* 20 */     0x3,  0x5,  /* Fire */
  /* 21 */     0x3,  0x6,  /* Purge */
  /* 22 */     0x3,  0x7,
  /* 23 */     0x3,  0x8,

  /* fuel depot */
  /* 24 */     0x4,  0x1,  /* Mist */
  /* 25 */     0x4,  0x2,  /* Mist Dump */
  /* 26 */     0x4,  0x3,  /* Mist Propane */

};
