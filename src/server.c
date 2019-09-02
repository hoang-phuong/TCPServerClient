#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <time.h>
#include <string.h>
#define PORT 8080

int main(int argc, char* argv[]){
    char sendBuff[1025];
    time_t ticks;
    int sockfd, connfd, len;
    struct sockaddr_in server_addr;
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd == -1){
        printf("Socket creation failed... \n");
    }
    else{
        printf("Socket successfully created... \n");
    }
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    server_addr.sin_port = htons(PORT);

    if(bind(sockfd, &server_addr, sizeof(server_addr)) != 0){
        printf("Socket bind failed,,, \n");
    }
    else{
        printf("Socket successfully binded... \n");
    }

    if(listen(sockfd,5) != 0){
        printf("Listen failed... \n");
    }
    else{
        printf("Server is listening... \n");
    }

    while(1){
        connfd = accept(sockfd, NULL, NULL);
        ticks = time(NULL);
        snprintf(sendBuff, sizeof(sendBuff), "%.24s\r\n", ctime(&ticks));
        printf("%s\n",sendBuff);
        write(connfd, sendBuff, strlen(sendBuff));
    }
    return 0;
}