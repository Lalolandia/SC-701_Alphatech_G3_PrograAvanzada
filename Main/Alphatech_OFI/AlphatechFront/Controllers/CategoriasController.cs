using AlphatechFront.Interfaces;
using AlphatechFront.Models;
using AlphatechFront.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AlphatechFront.Controllers
{
    [Authorize(Roles = "Admin")]
    public class CategoriasController : Controller
    {
        private readonly ICategoriaRepository _categoriaRepo;

        public CategoriasController(ICategoriaRepository categoriaRepo)
        {
            _categoriaRepo = categoriaRepo;
        }

        // 1. LISTAR
        public async Task<IActionResult> Index()
        {
            var categorias = await _categoriaRepo.ObtenerCategorias();
            return View(categorias);
        }

        // 2. CREAR (GET)
        public IActionResult Crear()
        {
            return View();
        }

        // 2. CREAR (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Crear(Categoria categoria)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    await _categoriaRepo.CrearCategoria(categoria);
                    TempData["Exito"] = "Categoría creada correctamente.";
                    return RedirectToAction(nameof(Index));
                }
                catch (Exception ex)
                {
                    TempData["Error"] = "Error al guardar: " + ex.Message;
                }
            }
            else
            {
                TempData["Error"] = "El formulario tiene datos inválidos.";
            }
            return View(categoria);
        }

        // 3. EDITAR (GET)
        public async Task<IActionResult> Editar(int id)
        {
            var categoria = await _categoriaRepo.ObtenerCategoriaPorId(id);
            if (categoria == null) return NotFound();
            return View(categoria);
        }

        // 3. EDITAR (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Editar(Categoria categoria)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    await _categoriaRepo.UpdateCategoria(categoria);
                    TempData["Exito"] = "Categoría actualizada.";
                    return RedirectToAction(nameof(Index));
                }
                catch (Exception ex)
                {
                    TempData["Error"] = "Error al actualizar: " + ex.Message;
                }
            }
            return View(categoria);
        }

        // 4. ELIMINAR (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Eliminar(int id)
        {
            try
            {
                await _categoriaRepo.DeleteCategoria(id);
                TempData["Exito"] = "Categoría eliminada del sistema.";
            }
            catch (Exception)
            {
                // Este catch atrapa el error de llave foránea de SQL Server
                TempData["Error"] = "¡No se puede eliminar! Esta categoría contiene productos asociados. Mueve o borra los productos primero.";
            }
            return RedirectToAction(nameof(Index));
        }
    }
}