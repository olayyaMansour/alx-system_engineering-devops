#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int infinite_while(void)
{
    while (1)
    {
        sleep(1);
    }
    return (0);
}

int main(void)
{
    pid_t zombie_pid;

    for (int i = 0; i < 5; i++)
    {
        zombie_pid = fork();

        if (zombie_pid > 0)
        {
            printf("Zombie process created, PID: %d\n", zombie_pid);
            sleep(1); // Sleep to allow the parent to fork additional children
        }
        else if (zombie_pid == 0)
        {
            exit(0); // Child exits immediately, becoming a zombie
        }
        else
        {
            perror("fork");
            exit(EXIT_FAILURE);
        }
    }

    infinite_while(); // Keep the parent process alive

    return (0);
}
