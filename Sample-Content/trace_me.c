#include <stdio.h>
#include <math.h>

int main() {
    double x = 45.0; // An arbitrary angle in degrees
    double y = 2.0;  // An arbitrary exponent

    // Convert angle to radians
    double x_rad = x * 3.14 / 180.0;

    // Calculate various results
    double sin_result = sin(x_rad);
    double cos_result = cos(x_rad);
    double sqrt_result = sqrt(x);
    double pow_result = pow(x, y);
    double log_result = log(x);

    // Print the results in a humorous manner
    printf("If you ever wonder what goes on in the world of math, here are some profound revelations:\n");
    printf("The sine of %.2f degrees (which is %.2f radians) is approximately %.2f.\n", x, x_rad, sin_result);
    printf("The cosine of %.2f degrees (which is %.2f radians) is approximately %.2f.\n", x, x_rad, cos_result);
    printf("The square root of %.2f is %.2f. Because we all need to break things down sometimes.\n", x, sqrt_result);
    printf("If you raise %.2f to the power of %.2f, you get %.2f. Because why not?\n", x, y, pow_result);
    printf("The natural logarithm of %.2f is %.2f. It's like asking how many times you need to multiply e to get %.2f.\n", x, log_result, x);

    printf("\nRemember, math might not solve all your problems, but it's a pretty good way to spend your time pretending you're doing something productive!\n");

    return 0;
}
