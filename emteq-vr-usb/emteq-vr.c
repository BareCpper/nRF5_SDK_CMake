// emteq-vr.cpp : Defines the entry point for the application.
//

#include "emteq-vr.h"

//#include "..\3rd_party\nRF5_SDK_16.0.0_98a08e2\components\libraries\delay\nrf_delay.h"
//#include "..\3rd_party\nRF5_SDK_16.0.0_98a08e2\components\boards\boards.h"

/**
 * @brief Function for application main entry.
 */
#include <stdbool.h>
#include <stdint.h>
#include "nrf_delay.h"
#include "boards.h"

 /**
  * @brief Function for application main entry.
  */
int main(void)
{
	/* Configure board. */
	bsp_board_init(BSP_INIT_LEDS);

	/* Toggle LEDs. */
	while (true)
	{
		for (int i = 0; i < LEDS_NUMBER; i++)
		{
			bsp_board_led_invert(i);
			nrf_delay_ms(500);
		}
	}
}