package com.WatchX.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @ Santoshi Paudel
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/home" })
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Transfer any session messages to request scope
		HttpSession session = request.getSession(false);
		if (session != null) {
			// Handle success message
			String successMessage = (String) session.getAttribute("successMessage");
			if (successMessage != null) {
				request.setAttribute("successMessage", successMessage);
				session.removeAttribute("successMessage");
			}
			
			// Handle error message
			String errorMessage = (String) session.getAttribute("errorMessage");
			if (errorMessage != null) {
				request.setAttribute("errorMessage", errorMessage);
				session.removeAttribute("errorMessage");
			}
		}
		
		request.getRequestDispatcher("WEB-INF/pages/home.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
