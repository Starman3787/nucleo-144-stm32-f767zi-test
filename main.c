#include "./headers/main.h"
#include "./headers/stm32f767xx.h"
#include <stdint.h>

int main(void)
{
    // Enable GPIO clocks
    RCC_AHB1ENR |= RCC_AHB1ENR_GPIOB_EN;
    RCC_AHB1ENR |= RCC_AHB1ENR_GPIOC_EN;
    
    // Initialise GPIOC pin for BUTTON
    GPIOC_MODER = 0x00000000;
    GPIOC_PUPDR = 0x01000000;

    // Initialise GPIOB pin for LED
    GPIOB_MODER = 0x00004000;
    GPIOB_OTYPER = 0x00000000;

    // Keep track of whether the button is pressed.
    uint8_t button_down = 0;
    while (1)
    {
        uint32_t idr_val = (GPIOC_IDR);
        if (idr_val & (1 << BUTTON_PIN))
        {
            // The button is pressed, so change the LED state
            if (!button_down)
            {
                GPIOB_ODR ^= (1 << LED_PIN);
            }
            button_down = 1;
        }
        else 
        {
            button_down = 0;
        }
    }
}