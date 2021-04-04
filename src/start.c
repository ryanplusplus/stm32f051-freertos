/*!
 * @file
 * @brief
 */

#include <stdint.h>

extern uint32_t _data_rom;
extern uint32_t _data_begin;
extern uint32_t _data_end;
extern uint32_t _bss_begin;
extern uint32_t _bss_end;
extern uint32_t _stack_top;

extern void main(void);

void reset_handler(void)
{
  uint32_t* source = &_data_rom;

  for(uint32_t* destination = &_data_begin; destination < &_data_end;) {
    *(destination++) = *(source++);
  }

  for(uint32_t* destination = &_bss_begin; destination < &_bss_end;) {
    *(destination++) = 0;
  }

  main();
}

void default_handler(void)
{
  while(1) {
  }
}

// Cortex-M0
void NMI_Handler(void) __attribute__((weak, alias("default_handler")));
void HardFault_Handler(void) __attribute__((weak, alias("default_handler")));
void SVC_Handler(void) __attribute__((weak, alias("default_handler")));
void PendSV_Handler(void) __attribute__((weak, alias("default_handler")));
void SysTick_Handler(void) __attribute__((weak, alias("default_handler")));

// Peripherals
void WWDG_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void PVD_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void RTC_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void FLASH_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void RCC_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void EXTI0_1_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void EXTI2_3_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void EXTI4_15_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void TSC_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void DMA1_Channel1_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void DMA1_Channel2_3_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void DMA1_Channel4_5_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void ADC1_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void TIM1_BRK_UP_TRG_COM_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void TIM1_CC_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void TIM2_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void TIM3_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void TIM6_DAC_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void TIM14_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void TIM15_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void TIM16_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void TIM17_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void I2C1_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void I2C2_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void SPI1_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void SPI2_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void USART1_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void USART2_IRQHandler(void) __attribute__((weak, alias("default_handler")));
void CEC_CAN_IRQHandler(void) __attribute__((weak, alias("default_handler")));

typedef void (*vector_t)(void);

const vector_t vector_table[] __attribute__((section(".vectors"))) = {
  // Cortex-M0
  (vector_t)&_stack_top,
  reset_handler,
  NMI_Handler,
  HardFault_Handler,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  SVC_Handler,
  0,
  0,
  PendSV_Handler,
  SysTick_Handler,

  // Peripherals
  WWDG_IRQHandler,
  PVD_IRQHandler,
  RTC_IRQHandler,
  FLASH_IRQHandler,
  RCC_IRQHandler,
  EXTI0_1_IRQHandler,
  EXTI2_3_IRQHandler,
  EXTI4_15_IRQHandler,
  TSC_IRQHandler,
  DMA1_Channel1_IRQHandler,
  DMA1_Channel2_3_IRQHandler,
  DMA1_Channel4_5_IRQHandler,
  ADC1_IRQHandler,
  TIM1_BRK_UP_TRG_COM_IRQHandler,
  TIM1_CC_IRQHandler,
  TIM2_IRQHandler,
  TIM3_IRQHandler,
  TIM6_DAC_IRQHandler,
  0,
  TIM14_IRQHandler,
  TIM15_IRQHandler,
  TIM16_IRQHandler,
  TIM17_IRQHandler,
  I2C1_IRQHandler,
  I2C2_IRQHandler,
  SPI1_IRQHandler,
  SPI2_IRQHandler,
  USART1_IRQHandler,
  USART2_IRQHandler,
  0,
  CEC_CAN_IRQHandler,
  0
};
