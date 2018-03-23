<html>
<head>
    <title>Hangman application</title>

    <link rel="stylesheet" href="hangman.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<body>
<ul id="movie">
</ul>
<div id="letter">
    <input type="text" id="currentLetter" name="currentLetter" placeholder="Letter"/>
    <input type="button" id="verify" value="Verify" onClick="verifyLetter()"/>
    <ul id="keyboard">
        <li class="letter" id="q" value="q" onclick="verifyLetterKeyboard('q')">q</li>
        <li class="letter" id="w" value="w" onclick="verifyLetterKeyboard('w')">w</li>
        <li class="letter" id="e" value="e" onclick="verifyLetterKeyboard('e')">e</li>
        <li class="letter" id="r" value="r" onclick="verifyLetterKeyboard('r')">r</li>
        <li class="letter" id="t" value="t" onclick="verifyLetterKeyboard('t')">t</li>
        <li class="letter" id="y" value="y" onclick="verifyLetterKeyboard('y')">y</li>
        <li class="letter" id="u" value="u" onclick="verifyLetterKeyboard('u')">u</li>
        <li class="letter" id="i" value="i" onclick="verifyLetterKeyboard('i')">i</li>
        <li class="letter" id="o" value="o" onclick="verifyLetterKeyboard('o')">o</li>
        <li class="letter" id="p" value="p" onclick="verifyLetterKeyboard('p')">p</li>

        <li class="letter" id="a" value="a" onclick="verifyLetterKeyboard('a')">a</li>
        <li class="letter" id="s" value="s" onclick="verifyLetterKeyboard('s')">s</li>
        <li class="letter" id="d" value="d" onclick="verifyLetterKeyboard('d')">d</li>
        <li class="letter" id="f" value="f" onclick="verifyLetterKeyboard('f')">f</li>
        <li class="letter" id="g" value="g" onclick="verifyLetterKeyboard('g')">g</li>
        <li class="letter" id="h" value="h" onclick="verifyLetterKeyboard('h')">h</li>
        <li class="letter" id="j" value="j" onclick="verifyLetterKeyboard('j')">j</li>
        <li class="letter" id="k" value="k" onclick="verifyLetterKeyboard('k')">k</li>
        <li class="letter" id="l" value="l" onclick="verifyLetterKeyboard('l')">l</li>
        <li class="letter" id="'" value="'" onclick="verifyLetterKeyboard('\'')">'</li>

        <li class="letter" id="z" value="z" onclick="verifyLetterKeyboard('z')">z</li>
        <li class="letter" id="x" value="x" onclick="verifyLetterKeyboard('x')">x</li>
        <li class="letter" id="c" value="c" onclick="verifyLetterKeyboard('c')">c</li>
        <li class="letter" id="v" value="v" onclick="verifyLetterKeyboard('v')">v</li>
        <li class="letter" id="b" value="b" onclick="verifyLetterKeyboard('b')">b</li>
        <li class="letter" id="n" value="n" onclick="verifyLetterKeyboard('n')">n</li>
        <li class="letter" id="m" value="m" onclick="verifyLetterKeyboard('m')">m</li>
    </ul>
</div>
<br>
<canvas id="hangmanDrawing"></canvas>
<br>
<button type="button" id="restart" onclick="loadMovie()">Restart</button>
</body>


<script>
    function loadMovie() {
        $.ajax({
            url: 'hangman?action=read'
        }).done(function (response) {
            var c = document.getElementById("hangmanDrawing");
            var ctx = c.getContext("2d");
            ctx.clearRect(0, 0, 300, 250);
            putMovieinHTML(response.movie);
        });
    }

    function putMovieinHTML(movie) {
        var chosenMovie = document.getElementById('movie');

        var listHtml = '';

        for (var i = 0; i < movie.length; i++) {
            var task = movie[i].toUpperCase();
            if (task == ' ') {
                listHtml += ' / ';
            }
            else {
                var taskHtml = '<li>' + task + ' </li>';
                listHtml += taskHtml;
            }
        }
        chosenMovie.innerHTML = listHtml;
    }

    function verifyLetterKeyboard(char) {

        $.ajax({
            url: 'hangman?action=write&character=' + char
        }).done(function (response) {
            putMovie(response.movie);
            draw(response.counter);
            completeGame(response.completeGame);
        });
    }

    function verifyLetter() {          //trimitem date
        var letter = document.getElementById('currentLetter').value;
        console.debug(letter);
        $.ajax({
            url: 'hangman?action=write&character=' + letter
        }).done(function (response) {
            putMovie(response.movie);
            draw(response.counter);
        });
    }

    function putMovie(movie) {
        var chosenMovie = document.getElementById('movie');

        var listHtml = '';

        for (var i = 0; i < movie.length; i++) {
            var task = movie[i].toUpperCase();
            if (task == ' ') {
                listHtml += ' / ';
            }
            else {
                var taskHtml = '<li>' + task + ' </li>';
                listHtml += taskHtml;
            }
        }
        chosenMovie.innerHTML = listHtml;
    }

    function draw(counter) {
        switch (counter) {
            case 1:
                drawStick1();
                break;
            case 2:
                drawStick2();
                break;
            case 3:
                drawStick3();
                break;
            case 4:
                drawHead();
                break;
            case 5:
                drawNeck();
                break;
            case 6:
                drawBody();
                break;
            case 7:
                drawLegs1();
                break;
            case 8:
                drawLegs2();
                break;
            case 9:
                drawHands1();
                break;
            case 10:
                drawHands2();
                break;
            case 11:
                gameover();
        }
    }

    function drawStick1() {
        var c = document.getElementById("hangmanDrawing");
        var ctx = c.getContext("2d");
        ctx.moveTo(40, 10);
        ctx.lineTo(40, 230);
        ctx.stroke();
    }

    function drawStick2() {
        var c = document.getElementById("hangmanDrawing");
        var ct = c.getContext("2d");
        ct.moveTo(40, 10);
        ct.lineTo(180, 10);
        ct.stroke();
    }

    function drawStick3() {
        var c = document.getElementById("hangmanDrawing");
        var ctx = c.getContext("2d");
        ctx.moveTo(180, 10);
        ctx.lineTo(180, 30);
        ctx.stroke();
    }

    function drawHead() {
        var c = document.getElementById("hangmanDrawing");
        var ctx = c.getContext("2d");
        ctx.beginPath();
        ctx.arc(180, 40, 10, 0, 2 * Math.PI);
        ctx.stroke();
    }

    function drawNeck() {
        var c = document.getElementById("hangmanDrawing");
        var ctx = c.getContext("2d");
        ctx.moveTo(180, 50);
        ctx.lineTo(180, 60);
        ctx.stroke();
    }

    function drawBody() {
    var c = document.getElementById("hangmanDrawing");
    var ctx = c.getContext("2d");
    ctx.beginPath();
    ctx.arc(180, 80, 20, 0, 2 * Math.PI);
    ctx.stroke();
    }

    function drawLegs1() {
        var c = document.getElementById("hangmanDrawing");
        var ctx = c.getContext("2d");
        ctx.moveTo(167, 95);
        ctx.lineTo(155, 140);
        ctx.stroke();
    }

    function drawLegs2() {
        var c = document.getElementById("hangmanDrawing");
        var ct = c.getContext("2d");
        ct.moveTo(193, 95);
        ct.lineTo(205, 140);
        ct.stroke();
    }

    function drawHands1() {
        var c = document.getElementById("hangmanDrawing");
        var ctx = c.getContext("2d");
        ctx.moveTo(167, 65);
        ctx.lineTo(145, 35);
        ctx.stroke();
    }

    function drawHands2() {
        var c = document.getElementById("hangmanDrawing");
        var ct = c.getContext("2d");
        ct.moveTo(193, 65);
        ct.lineTo(222, 35);
        ct.stroke();
    }

    function gameover() {
        var c = document.getElementById("hangmanDrawing");
        var ctx = c.getContext("2d");
        ctx.font = "40px Arial";
        ctx.fillStyle = "red";
        ctx.fillText("GAME OVER", 30, 100);
    }

    function completeGame(completeGame) {
        console.log(completeGame);
        if(completeGame === 1) {
            var c = document.getElementById("hangmanDrawing");
            var ctx = c.getContext("2d");
            ctx.font = "40px Arial";
            ctx.fillStyle = "blue";
            ctx.fillText("Congrats!", 30, 100);
        }
    }
</script>
</html>
