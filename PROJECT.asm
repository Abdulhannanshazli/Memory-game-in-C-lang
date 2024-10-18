#include <reg51.h>   // Standard header for 8051

// Pin Definitions
sbit LED1 = P2^0;  // LED1 on P2.0
sbit LED2 = P2^1;  // LED2 on P2.1
sbit LED3 = P2^2;  // LED3 on P2.2
sbit LED4 = P2^3;  // LED4 on P2.3

sbit BTN1 = P1^0;  // Button1 on P1.0
sbit BTN2 = P1^1;  // Button2 on P1.1
sbit BTN3 = P1^2;  // Button3 on P1.2
sbit BTN4 = P1^3;  // Button4 on P1.3

sbit BUZZER = P3^5;  // Buzzer on P3.5

// Function declarations
void delay(unsigned int time);
void blink_led(int led);
int get_random();
void game_over();
int check_button(int led);

void main() {
    int sequence[4];  // Array to store random sequence
    int i, j, user_input, correct;
    
    // Main Game Loop
    while (1) {
        // Generate Random Sequence (4 steps in this example)
        for (i = 0; i < 4; i++) {
            sequence[i] = get_random();  // Get a random number between 1 and 4
            blink_led(sequence[i]);      // Show the random sequence
        }

        // User Input Phase
        correct = 1;  // Flag to check if user is correct
        for (j = 0; j < 4; j++) {
            user_input = check_button(sequence[j]);  // Check user button input
            if (user_input == 0) {
                correct = 0;  // If incorrect button is pressed
                break;        // End game on wrong input
            }
        }

        // If user was incorrect, end game
        if (correct == 0) {
            game_over();  // Sound buzzer and end the game
        }

        delay(1000);  // Wait before the next round
    }
}

// Function to blink the appropriate LED
void blink_led(int led) {
    switch (led) {
        case 1: 
            LED1 = 1; 
            delay(500); 
            LED1 = 0; 
            break;
        case 2: 
            LED2 = 1; 
            delay(500); 
            LED2 = 0; 
            break;
        case 3: 
            LED3 = 1; 
            delay(500); 
            LED3 = 0; 
            break;
        case 4: 
            LED4 = 1; 
            delay(500); 
            LED4 = 0; 
            break;
    }
    delay(500);  // Delay between LED blinks
}

// Function to check user button input
int check_button(int led) {
    int result = 0;
    switch (led) {
        case 1: 
            if (BTN1 == 0) { 
                delay(20); 
                if (BTN1 == 0) result = 1;  // Button 1 pressed correctly
            }
            break;
        case 2: 
            if (BTN2 == 0) { 
                delay(20); 
                if (BTN2 == 0) result = 1;  // Button 2 pressed correctly
            }
            break;
        case 3: 
            if (BTN3 == 0) { 
                delay(20); 
                if (BTN3 == 0) result = 1;  // Button 3 pressed correctly
            }
            break;
        case 4: 
            if (BTN4 == 0) { 
                delay(20); 
                if (BTN4 == 0) result = 1;  // Button 4 pressed correctly
            }
            break;
    }
    delay(500);  // Debounce delay
    return result;
}

// Function to generate a random number between 1 and 4
int get_random() {
    return (rand() % 4) + 1;  // Returns 1, 2, 3, or 4
}

// Function to end the game with a buzzer sound
void game_over() {
    BUZZER = 1;  // Turn on the buzzer
    delay(1000);  // Buzzer sound for 1 second
    BUZZER = 0;  // Turn off the buzzer
    while (1);  // Stop the game here
}

// Simple delay function (milliseconds)
void delay(unsigned int time) {
    unsigned int i, j;
    for (i = 0; i < time; i++) {
        for (j = 0; j < 1275; j++);
    }
}
