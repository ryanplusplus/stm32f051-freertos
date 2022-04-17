/*!
 * @file
 * @brief
 */

#ifndef interrupts_h
#define interrupts_h

#include "stm32f0xx.h"

static inline void interrupts_enable(void)
{
  __enable_irq();
}

static inline void interrupts_disable(void)
{
  __disable_irq();
}

static inline void interrupts_wait_for_interrupt(void)
{
  __WFI();
}

#define interrupts_critical_section(...) \
  do {                                   \
    uint32_t primask = __get_PRIMASK();  \
    __disable_irq();                     \
    __VA_ARGS__                          \
    __set_PRIMASK(primask);              \
  } while(0)

#endif
