public class BussinessLogic {

    private char[] movieArray;
    private char[] replacementArray;
    private int foundLetter = 0;
    public int counter = 0;
    public int completeGame = 0;

    private static BussinessLogic m;

    public static BussinessLogic getInstance() {
        if (m == null) {
            m = new BussinessLogic();
        }
        return m;
    }

    public char[] lettersMovie(String movie) {
        movieArray = movie.toCharArray();
        replacementArray = new char[movieArray.length];

        for (int i = 0; i < movieArray.length; i++) {
            if (movieArray[i] != ' ') {
                replacementArray[i] = '_';
            } else {
                replacementArray[i] = ' ';
            }
        }
        return replacementArray;
    }

    public char[] replaceLetterByLetter(char[] c, char[] initialMovie, char currentCharacter) {

        foundLetter = 0;
        for (int i = 0; i < c.length && counter <= 11; i++) {
            if (initialMovie[i] == currentCharacter) {
                replacementArray[i] = currentCharacter;
                foundLetter = 1;
            }
        }
        if (foundLetter == 0) {
            counter++;
            System.out.println(counter + "bl");
        }

        boolean movieNotComplete = false;
        for (int i = 0; i < replacementArray.length; i++) {
            if (replacementArray[i] == '_') {
                movieNotComplete = true;
            }
        }
        if (!movieNotComplete) {
            completeGame = 1;
        }

        return replacementArray;
    }
}