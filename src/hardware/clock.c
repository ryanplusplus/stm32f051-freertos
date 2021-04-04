/*!
 * @file
 * @brief
 */

#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_system.h"
#include "clock.h"

void clock_init(void)
{
  LL_FLASH_EnablePrefetch();

  LL_FLASH_SetLatency(LL_FLASH_LATENCY_1);

  LL_RCC_HSI_Enable();
  while(!LL_RCC_HSI_IsReady()) {
  };

  LL_RCC_PLL_ConfigDomain_SYS(LL_RCC_PLLSOURCE_HSI_DIV_2, LL_RCC_PLL_MUL_12);

  LL_RCC_PLL_Enable();
  while(!LL_RCC_PLL_IsReady()) {
  };

  LL_RCC_SetAHBPrescaler(LL_RCC_SYSCLK_DIV_1);
  LL_RCC_SetSysClkSource(LL_RCC_SYS_CLKSOURCE_PLL);
  while(LL_RCC_GetSysClkSource() != LL_RCC_SYS_CLKSOURCE_STATUS_PLL) {
  };

  LL_RCC_SetAPB1Prescaler(LL_RCC_APB1_DIV_1);

  SystemCoreClockUpdate();
}
