package com.WatchX.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.List;
import com.WatchX.model.ProductModel;
import com.WatchX.service.AddService;

/**
 * Servlet implementation class CollectionsController
 */
@WebServlet("/collections")
public class CollectionsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AddService productService;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CollectionsController() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    public void init() throws ServletException {
        try {
            this.productService = new AddService();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize ProductService", e);
        }
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			List<ProductModel> products = productService.getAllProducts();
			request.setAttribute("products", products);
			request.getRequestDispatcher("/WEB-INF/pages/collections.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error fetching products: " + e.getMessage());
			request.getRequestDispatcher("/WEB-INF/pages/collections.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
