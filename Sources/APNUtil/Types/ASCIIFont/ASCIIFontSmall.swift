//
//  ASCIIFontSmall.swift
//  Test - APNConsoleView Sample
//
// Font Source:
// https://www.patorjk.com/software/taag/#p=display&h=0&v=0&f=Small&t=%20%0Aa%0Ab%0Ac%0Ad%0Ae%0Af%0Ag%0Ah%0Ai%0Aj%0Ak%0Al%0Am%0An%0Ao%0Ap%0Aq%0Ar%0As%0At%0Au%0Av%0Aw%0Ax%0Ay%0Az%0AA%0AB%0AC%0AD%0AE%0AF%0AG%0AH%0AI%0AJ%0AK%0AL%0AM%0AN%0AO%0AP%0AQ%0AR%0AS%0AT%0AU%0AV%0AW%0AX%0AY%0AZ%0A1%0A2%0A3%0A4%0A5%0A6%0A7%0A8%0A9%0A0%0A.%0A!%0A%3F%0A%2F%0A%5C%0A%22%0A'%0A%2C%0A%3B%0A%3A%0A%25%0A%24%0A%23%0A%40%0A%26%0A*%0A(%0A)%0A-%0A%3D%0A%2B%0A%5E%0A%5B%0A%5D%0A_%0A%3E%0A%3C%0A%60%0A~
//
//  Created by Aaron Nance on 7/11/24.
//

struct ASCIIFontSmall: ASCIIFont {
    
    let lineHeight = 5
    
    var alphabet = [
        /*---SPACE--*/
        " " :
        """
            \n
            \n
            \n
            \n
            \n
        """,
        /*---LOWER--*/
        "a" :
        """
                \n
          __ _  \n
         / _` | \n
         \\__,_| \n
                \n
        """,
        /*----------*/
        "b" :
        """
          _     \n
         | |__  \n
         | '_ \\ \n
         |_.__/ \n
                \n
        """,
        /*----------*/
        "c" :
        """
               \n
          __   \n
         / _|  \n
         \\__|  \n
               \n
        """,
        /*----------*/
        "d" :
        """
             _  \n
          __| | \n
         / _` | \n
         \\__,_| \n
                \n
        """,
        /*----------*/
        "e" :
        """
               \n
          ___  \n
         / -_) \n
         \\___| \n
               \n
        """,
        /*----------*/
        "f" :
        """
           __  \n
          / _| \n
         |  _| \n
         |_|   \n
               \n
        """,
        /*----------*/
        "g" :
        """
                \n
          __ _  \n
         / _` | \n
         \\__, | \n
         |___/  \n
        """,
        /*----------*/
        "h" :
        """
          _     \n
         | |_   \n
         | ' \\  \n
         |_||_| \n
                \n
        """,
        /*----------*/
        "i" :
        """
          _  \n
         (_) \n
         | | \n
         |_| \n
             \n
        """,
        /*----------*/
        "j" :
        """
            _  \n
           (_) \n
           | | \n
          _/ | \n
         |__/  \n
        """,
        /*----------*/
        "k" :
        """
          _    \n
         | |__ \n
         | / / \n
         |_\\_\\ \n
               \n
        """,
        /*----------*/
        "l" :
        """
          _  \n
         | | \n
         | | \n
         |_| \n
             \n
        """,
        /*----------*/
        "m" :
        """
                 \n
          _ __   \n
         | '  \\  \n
         |_|_|_| \n
                 \n
        """,
        /*----------*/
        "n" :
        """
                \n
          _ _   \n
         | ' \\  \n
         |_||_| \n
                \n
        """,
        /*----------*/
        "o" :
        """
               \n
          ___  \n
         / _ \\ \n
         \\___/ \n
               \n
        """,
        /*----------*/
        "p" :
        """
                \n
          _ __  \n
         | '_ \\ \n
         | .__/ \n
         |_|    \n
        """,
        /*----------*/
        "q" :
        """
                \n
          __ _  \n
         / _` | \n
         \\__, | \n
            |_| \n
        """,
        /*----------*/
        "r" :
        """
               \n
          _ _  \n
         | '_| \n
         |_|   \n
               \n
        """,
        /*----------*/
        "s" :
        """
              \n
          ___ \n
         (_-< \n
         /__/ \n
              \n
        """,
        /*----------*/
        "t" :
        """
          _    \n
         | |_  \n
         |  _| \n
          \\__| \n
               \n
        """,
        /*----------*/
        "u" :
        """
                \n
          _  _  \n
         | || | \n
          \\_,_| \n
                \n
        """,
        /*----------*/
        "v" :
        """
               \n
         __ __ \n
         \\ V / \n
          \\_/  \n
               \n
        """,
        /*----------*/
        "w" :
        """
                  \n
         __ __ __ \n
         \\ V  V / \n
          \\_/\\_/  \n
                  \n
        """,
        /*----------*/
        "x" :
        """
               \n
         __ __ \n
         \\ \\ / \n
         /_\\_\\ \n
               \n
        """,
        /*----------*/
        "y" :
        """
                \n
          _  _  \n
         | || | \n
          \\_, | \n
          |__/  \n
        """,
        /*----------*/
        "z" :
        """
              \n
          ___ \n
         |_ / \n
         /__| \n
              \n
        """,
        /*---UPPER--*/
        "A" :
        """
            _    \n
           /_\\   \n
          / _ \\  \n
         /_/ \\_\\ \n
                 \n
        """,
        /*----------*/
        "B" :
        """
          ___  \n
         | _ ) \n
         | _ \\ \n
         |___/ \n
               \n
        """,
        /*----------*/
        "C" :
        """
           ___  \n
          / __| \n
         | (__  \n
          \\___| \n
                \n
        """,
        /*----------*/
        "D" :
        """
          ___   \n
         |   \\  \n
         | |) | \n
         |___/  \n
                \n
        """,
        /*----------*/
        "E" :
        """
          ___  \n
         | __| \n
         | _|  \n
         |___| \n
               \n
        """,
        /*----------*/
        "F" :
        """
          ___  \n
         | __| \n
         | _|  \n
         |_|   \n
               \n
        """,
        /*----------*/
        "G" :
        """
           ___  \n
          / __| \n
         | (_ | \n
          \\___| \n
                \n
        """,
        /*----------*/
        "H" :
        """
          _  _  \n
         | || | \n
         | __ | \n
         |_||_| \n
                \n
        """,
        /*----------*/
        "I" :
        """
          ___  \n
         |_ _| \n
          | |  \n
         |___| \n
               \n
        """,
        /*----------*/
        "J" :
        """
             _  \n
          _ | | \n
         | || | \n
          \\__/  \n
                \n
        """,
        /*----------*/
        "K" :
        """
          _  __ \n
         | |/ / \n
         | ' <  \n
         |_|\\_\\ \n
                \n
        """,
        /*----------*/
        "L" :
        """
          _     \n
         | |    \n
         | |__  \n
         |____| \n
                \n
        """,
        /*----------*/
        "M" :
        """
          __  __  \n
         |  \\/  | \n
         | |\\/| | \n
         |_|  |_| \n
                  \n
        """,
        /*----------*/
        "N" :
        """
          _  _  \n
         | \\| | \n
         | .` | \n
         |_|\\_| \n
                \n
        """,
        /*----------*/
        "O" :
        """
           ___    \n
          / _ \\   \n
         | (_) |  \n
          \\___/   \n
                  \n
        """,
        /*----------*/
        "P" :
        """
          ___  \n
         | _ \\ \n
         |  _/ \n
         |_|   \n
               \n
        """,
        /*----------*/
        "Q" :
        """
           ___   \n
          / _ \\  \n
         | (_) | \n
          \\__\\_\\ \n
                 \n
        """,
        /*----------*/
        "R" :
        """
          ___  \n
         | _ \\ \n
         |   / \n
         |_|_\\ \n
               \n
        """,
        /*----------*/
        "S" :
        """
          ___  \n
         / __| \n
         \\__ \\ \n
         |___/ \n
               \n
        """,
        /*----------*/
        "T" :
        """
          _____  \n
         |_   _| \n
           | |   \n
           |_|   \n
                 \n
        """,
        /*----------*/
        "U" :
        """
          _   _  \n
         | | | | \n
         | |_| | \n
          \\___/  \n
                 \n
        """,
        /*----------*/
        "V" :
        """
         __   __ \n
         \\ \\ / / \n
          \\ V /  \n
           \\_/   \n
                 \n
        """,
        /*----------*/
        "W" :
        """
         __      __ \n
         \\ \\    / / \n
          \\ \\/\\/ /  \n
           \\_/\\_/   \n
                    \n
        """,
        /*----------*/
        "X" :
        """
         __  __ \n
         \\ \\/ / \n
          >  <  \n
         /_/\\_\\ \n
                \n
        """,
        /*----------*/
        "Y" :
        """
         __   __ \n
         \\ \\ / / \n
          \\ V /  \n
           |_|   \n
                 \n
        """,
        /*----------*/
        "Z" :
        """
          ____ \n
         |_  / \n
          / /  \n
         /___| \n
               \n
        """,
        /*--NUMBERS-*/
        "1" :
        """
          _  \n
         / | \n
         | | \n
         |_| \n
             \n
        """,
        /*----------*/
        "2" :
        """
          ___  \n
         |_  ) \n
          / /  \n
         /___| \n
               \n
        """,
        /*----------*/
        "3" :
        """
          ____ \n
         |__ / \n
          |_ \\ \n
         |___/ \n
               \n
        """,
        /*----------*/
        "4" :
        """
          _ _   \n
         | | |  \n
         |_  _| \n
           |_|  \n
                \n
        """,
        /*----------*/
        "5" :
        """
          ___  \n
         | __| \n
         |__ \\ \n
         |___/ \n
               \n
        """,
        /*----------*/
        "6" :
        """
           __  \n
          / /  \n
         / _ \\ \n
         \\___/ \n
               \n
        """,
        /*----------*/
        "7" :
        """
          ____  \n
         |__  | \n
           / /  \n
          /_/   \n
                \n
        """,
        /*----------*/
        "8" :
        """
          ___  \n
         ( _ ) \n
         / _ \\ \n
         \\___/ \n
               \n
        """,
        /*----------*/
        "9" :
        """
          ___  \n
         / _ \\ \n
         \\_, / \n
          /_/  \n
               \n
        """,
        /*----------*/
        "0" :
        """
           __   \n
          /  \\  \n
         | () | \n
          \\__/  \n
                \n
        """,
        /*--SYMBOLS-*/
        "." :
        """
             \n
             \n
          _  \n
         (_) \n
             \n
        """,
        /*----------*/
        "!" :
        """
          _  \n
         | | \n
         |_| \n
         (_) \n
             \n
        """,
        /*----------*/
        "?" :
        """
          ___  \n
         |__ \\ \n
           /_/ \n
          (_)  \n
               \n
        """,
        /*----------*/
        "/" :
        """
            __ \n
           / / \n
          / /  \n
         /_/   \n
               \n
        """,
        /*----------*/
        "\\" :
        """
         __    \n
         \\ \\   \n
          \\ \\  \n
           \\_\\ \n
               \n
        """,
        /*----------*/
        "\"" :
        """
          _ _  \n
         ( | ) \n
          V V  \n
               \n
               \n
        """,
        /*----------*/
        "'" :
        """
          _  \n
         ( ) \n
         |/  \n
             \n
             \n
        """,
        /*----------*/
        "," :
        """
             \n
             \n
          _  \n
         ( ) \n
         |/  \n
        """,
        /*----------*/
        ";" :
        """
          _  \n
         (_) \n
          _  \n
         ( ) \n
         |/  \n
        """,
        /*----------*/
        ":" :
        """
          _  \n
         (_) \n
          _  \n
         (_) \n
             \n
        """,
        /*----------*/
        "%" :
        """
          _  __  \n
         (_)/ /  \n
           / /_  \n
          /_/(_) \n
                 \n
        """,
        /*----------*/
        "$" :
        """
              \n
          ||_ \n
         (_-< \n
         / _/ \n
          ||  \n
        """,
        /*----------*/
        "#" :
        """
            _ _    \n
          _| | |_  \n
         |_  .  _| \n
         |_     _| \n
           |_|_|   \n
        """,
        /*----------*/
        "@" :
        """
           ____   \n
          / __ \\  \n
         / / _` | \n
         \\ \\__,_| \n
          \\____/  \n
        """,
        /*----------*/
        "&" :
        """
          __      \n
         / _|___  \n
         > _|_ _| \n
         \\_____|  \n
                  \n
        """,
        /*----------*/
        "*" :
        """
              \n
         _/\\_ \n
         >  < \n
          \\/  \n
              \n
        """,
        /*----------*/
        "(" :
        """
           __ \n
          / / \n
         | |  \n
         | |  \n
          \\_\\ \n
        """,
        /*----------*/
        ")" :
        """
         __   \n
         \\ \\  \n
          | | \n
          | | \n
         /_/  \n
        """,
        /*----------*/
        "-" :
        """
               \n
          ___  \n
         |___| \n
               \n
               \n
        """,
        /*----------*/
        "=" :
        """
               \n
          ___  \n
         |___| \n
         |___| \n
               \n
        """,
        /*----------*/
        "+" :
        """
            _    \n
          _| |_  \n
         |_   _| \n
           |_|   \n
                 \n
        """,
        /*----------*/
        "^" :
        """
          /\\  \n
         |/\\| \n
              \n
              \n
              \n
        """,
        /*----------*/
        "[" :
        """
          __  \n
         | _| \n
         | |  \n
         | |  \n
         |__| \n
        """,
        /*----------*/
        "]" :
        """
          __  \n
         |_ | \n
          | | \n
          | | \n
         |__| \n
        """,
        /*----------*/
        "_" :
        """
               \n
               \n
               \n
          ___  \n
         |___| \n
        """,
        /*----------*/
        ">" :
        """
         __   \n
         \\ \\  \n
          > > \n
         /_/  \n
              \n
        """,
        /*----------*/
        "<" :
        """
           __ \n
          / / \n
         < <  \n
          \\_\\ \n
              \n
        """,
        /*----------*/
        "`" :
        """
          _  \n
         ( ) \n
          \\| \n
             \n
             \n
        """,
        /*----------*/
        "~" :
        """
          /\\/| \n
         |/\\/  \n
               \n
               \n
               \n
        """,
        /*--MISSING-*/
        "¿" :
        """
         ¿¿¿¿ \n
         ¿¿¿¿ \n
         ¿¿¿¿ \n
         ¿¿¿¿ \n
         ¿¿¿¿ \n
        """
        /*----------*/
    ]
    
}