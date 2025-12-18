using AlphatechFront.Models;
using AlphatechFront.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore; // Necesario para .CountAsync()

namespace AlphatechFront.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AdminController : Controller
    {
        private readonly IVentaRepository _ventaRepo;
        private readonly IProductoRepository _productoRepo;
        private readonly UserManager<Usuario> _userManager;

        public AdminController(IVentaRepository ventaRepo, IProductoRepository productoRepo, UserManager<Usuario> userManager)
        {
            _ventaRepo = ventaRepo;
            _productoRepo = productoRepo;
            _userManager = userManager;
        }

        public async Task<IActionResult> Index()
        {
            // 1. Obtener datos reales
            var ventas = await _ventaRepo.ObtenerVentas();
            var productos = await _productoRepo.ObtenerProductosCatalogo(null, null); // Trae todos
            var totalUsuarios = await _userManager.Users.CountAsync();

            // 2. Calcular estadísticas
            var totalIngresos = ventas.Sum(v => v.Total);
            var totalVentas = ventas.Count();
            var totalProductos = productos.Count();
            var ordenesPendientes = ventas.Count(v => v.Estado == "Pendiente");

            // 3. Pasar datos a la vista usando ViewBag (o podrías crear un ViewModel)
            ViewBag.TotalIngresos = totalIngresos;
            ViewBag.TotalVentas = totalVentas;
            ViewBag.TotalProductos = totalProductos;
            ViewBag.TotalUsuarios = totalUsuarios;
            ViewBag.OrdenesPendientes = ordenesPendientes;

            // Pasamos las últimas 5 ventas para la tabla rápida
            return View(ventas.Take(5));
        }
    }
}