using AlphatechFront.Models;
using AlphatechFront.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AlphatechFront.Controllers
{
    [Authorize(Roles = "Admin")]
    public class VentasController : Controller
    {
        private readonly IVentaRepository _ventaRepo;

        public VentasController(IVentaRepository ventaRepo)
        {
            _ventaRepo = ventaRepo;
        }

        // 1. LISTA DE PEDIDOS
        public async Task<IActionResult> Index()
        {
            var ventas = await _ventaRepo.ObtenerVentas();
            return View(ventas);
        }

        // 2. DETALLE DEL PEDIDO (Factura)
        public async Task<IActionResult> Detalle(int id)
        {
            var cabecera = await _ventaRepo.ObtenerVentaPorId(id);
            if (cabecera == null) return NotFound();

            var detalles = await _ventaRepo.ObtenerDetallesDeVenta(id);

            var viewModel = new VentaDetalleViewModel
            {
                Cabecera = cabecera,
                Detalles = detalles
            };

            return View(viewModel);
        }

        // 3. CAMBIAR ESTADO (Para el Service Desk)
        [HttpPost]
        public async Task<IActionResult> CambiarEstado(int id, string estado)
        {
            await _ventaRepo.ActualizarEstadoVenta(id, estado);

            TempData["Exito"] = $"El pedido #{id} ha cambiado a estado: {estado}";
            return RedirectToAction("Detalle", new { id = id });
        }
    }
}