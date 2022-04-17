/*!
 * @file
 * @brief
 */

#include "time_source.h"
#include "FreeRTOS.h"
#include "task.h"

static tiny_time_source_ticks_t ticks(i_tiny_time_source_t* self)
{
  (void)self;
  return (tiny_time_source_ticks_t)xTaskGetTickCount();
}

static const i_tiny_time_source_api_t api = { ticks };

i_tiny_time_source_t* time_source_init(void)
{
  static i_tiny_time_source_t self;
  self.api = &api;
  return &self;
}
