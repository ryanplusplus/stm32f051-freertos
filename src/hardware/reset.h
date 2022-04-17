/*!
 * @file
 * @brief
 */

#ifndef reset_h
#define reset_h

#include "stm32f0xx.h"

static inline void reset(void)
{
  NVIC_SystemReset();
}

#endif
