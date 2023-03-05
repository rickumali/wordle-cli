//  mock1.c
//  
//  Created by Rick Umali on 3/4/23.

#include "mock1.h"

#include <ncurses.h>
#include <string.h>
#include <stdlib.h>

int getrandom_int() {
    return((int) random());
}

void updateGuessRowGuiWide(int g, char *s) {
    int offset = 12;
    int y = g + 4;
    mvprintw(y, 8, "%d: |   |   |   |   |   |", g);
    int len = strlen(s);
    if (len >= 5) {
        len = 5;
    }
    for (int i = 0; i < len; i++) {
        int color = getrandom_int() % 3;
        switch(color) {
            case 0:
                attron(COLOR_PAIR(2));
                break;
            case 1:
                attron(COLOR_PAIR(3));
                break;
            case 2:
                attron(COLOR_PAIR(4));
                break;
            default:
                break;
        }
        mvprintw(y, offset, " %c ", s[i]);
        attroff(COLOR_PAIR(1));
        offset+=4;
    }
}

int main()
{
    char str[80];
    char prompt[] = "Guess (N of 6)? ";
    int row, col;
    int guess_count = 1;
    initscr();
    start_color();
    init_pair(2, COLOR_BLACK, COLOR_WHITE);
    init_pair(3, COLOR_BLACK, COLOR_GREEN);
    init_pair(4, COLOR_BLACK, COLOR_YELLOW);
    getmaxyx(stdscr, row, col);
    mvprintw(3, 3, "wordle-cli (by Rick Umali)");
    mvprintw(5, 8, "1: |   |   |   |   |   |");
    mvprintw(6, 8, "2: |   |   |   |   |   |");
    mvprintw(7, 8, "3: |   |   |   |   |   |");
    mvprintw(8, 8, "4: |   |   |   |   |   |");
    mvprintw(9, 8, "5: |   |   |   |   |   |");
    mvprintw(10, 8, "6: |   |   |   |   |   |");
    mvprintw(12, 10, "Q W E R T Y U I O P");
    mvprintw(13, 11, "A S D F G H J K L");
    mvprintw(14, 12, "Z X C V B N M");
prompt:
    mvprintw(16, 3, "Guess (%d of 6)", guess_count);
    mvprintw(16, 3 + strlen(prompt), "         ");
    move(16, 3 + strlen(prompt));
    refresh();
    getstr(str);
    mvprintw(17, 3, "Entered: %s", str);
    updateGuessRowGuiWide(guess_count, str);
    if (guess_count < 6) {
        guess_count++;
        goto prompt;
    } else {
        mvprintw(17, 3, "That's that! Any key to quit!");
    }
    getch();
    endwin();
    printf("row=%d, col=%d\n", row, col);
    return 0;
}
