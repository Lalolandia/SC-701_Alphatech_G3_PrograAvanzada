using System.Diagnostics;
using AlphatechFront.Models;
using AlphatechFront.Repositories; // <--- NECESARIO PARA USAR EL REPOSITORIO
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AlphatechFront.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IProductoRepository _productoRepo; // <--- CAMPO NUEVO

        // Inyectamos tanto el Logger como el Repositorio de Productos
        public HomeController(ILogger<HomeController> logger, IProductoRepository productoRepo)
        {
            _logger = logger;
            _productoRepo = productoRepo;
        }

        // Convertimos a ASYNC TASK para hacer la llamada a la BD
        public async Task<IActionResult> Index()
        {
            // Obtenemos los productos (sin filtros)
            var productos = await _productoRepo.ObtenerProductosCatalogo(null, null);

            // Pasamos a la vista solo los primeros 4 para mostrarlos como "Destacados"
            return View(productos.Take(4));
        }

        [Authorize]
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}