import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/hangman")
    public class ServletBL extends HttpServlet {

        private char[] movieChar;

        @Override
        protected void service(HttpServletRequest req, HttpServletResponse resp)   throws ServletException, IOException {
            String action = req.getParameter("action");

            if (action != null && action.equals("read"))
                read(req, resp);
            else if (action != null && action.equals("write"))
                write(req, resp);
        }

        private void read(HttpServletRequest req, HttpServletResponse resp)  {

            String movie = null;
            try {
                movie = new DBOperations().getMovie();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            BussinessLogic bl = BussinessLogic.getInstance();
            movieChar = bl.lettersMovie(movie);

            System.out.println(movie);

            HttpSession session = req.getSession();
            session.setAttribute("movie", movie.toCharArray());

            bl.counter=0;
            bl.completeGame=0;


            JSONObject json = new JSONObject();
            json.put("movie", movieChar);
            System.out.println(json.toString());

            returnJsonResponse(resp, json.toString());
        }

        private void write(HttpServletRequest req, HttpServletResponse resp) {
            BussinessLogic bl = BussinessLogic.getInstance();

            if (bl.completeGame == 0) {
                String character = req.getParameter("character");
                char ch = character.charAt(0);

                char[] initialMovie = null;
                HttpSession session = req.getSession();
                Object o = session.getAttribute("movie");
                if (o != null) {
                    initialMovie = (char[]) o;
                }

                movieChar = bl.replaceLetterByLetter(movieChar, initialMovie, ch);
                int c = bl.counter;
                int completeGame = bl.completeGame;
                System.out.println(bl.completeGame);

                JSONObject json = new JSONObject();
                json.put("movie", movieChar);
                json.put("counter", c);
                json.put("completeGame", completeGame);
                System.out.println(json.toString());

                returnJsonResponse(resp, json.toString());
            }
        }

        private void returnJsonResponse(HttpServletResponse response, String jsonResponse) {
            response.setContentType("application/json");
            PrintWriter pr = null;
            try {
                pr = response.getWriter();
            } catch (IOException e) {
                e.printStackTrace();
            }
            assert pr != null;
            pr.write(jsonResponse);
            pr.close();
        }

    }

