using AlphatechFront.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AlphatechFront.Controllers
{
    [Authorize(Roles = "Admin")] // Protegido solo para Admins
    public class ProductosController : Controller
    {
        private readonly IProductoRepository _productoRepo;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public ProductosController(IProductoRepository productoRepo, IWebHostEnvironment webHostEnvironment)
        {
            _productoRepo = productoRepo;
            _webHostEnvironment = webHostEnvironment;
        }

        // GET: Lista Admin
        public async Task<IActionResult> Index()
        {
            var productos = await _productoRepo.ObtenerProductos();
            return View(productos);
        }

        // GET: Catálogo Público
        [AllowAnonymous]
        public async Task<IActionResult> Catalogo()
        {
            var productos = await _productoRepo.ObtenerProductos();
            return View(productos);
        }

        // --- CREAR ---
        public async Task<IActionResult> Crear()
        {
            // Cargamos las categorías para el Dropdown
            var categorias = await _productoRepo.ObtenerCategoriasParaSelect();
            ViewBag.Categorias = new Microsoft.AspNetCore.Mvc.Rendering.SelectList(categorias, "Id", "Nombre");

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Crear(Producto modelo, IFormFile? imagenArchivo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    modelo.ImagenUrl = await SubirImagen(imagenArchivo);
                    await _productoRepo.CrearProducto(modelo);

                    // MENSAJE DE ÉXITO
                    TempData["Exito"] = "El producto se ha creado correctamente.";
                    return RedirectToAction(nameof(Index));
                }
                catch (Exception ex)
                {
                    TempData["Error"] = "Error al guardar en base de datos: " + ex.Message;
                }
            }
            else
            {
                TempData["Error"] = "Por favor corrige los errores en el formulario.";
            }

            // Recargar categorias si falla
            var categorias = await _productoRepo.ObtenerCategoriasParaSelect();
            ViewBag.Categorias = new Microsoft.AspNetCore.Mvc.Rendering.SelectList(categorias, "Id", "Nombre");
            return View(modelo);
        }

        // --- EDITAR ---
        public async Task<IActionResult> Editar(int id)
        {
            var producto = await _productoRepo.ObtenerProductoPorId(id);
            if (producto == null) return NotFound();
            var categorias = await _productoRepo.ObtenerCategoriasParaSelect();
            ViewBag.Categorias = new Microsoft.AspNetCore.Mvc.Rendering.SelectList(categorias, "Id", "Nombre", producto.CategoriaId);
            
            return View(producto);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Editar(Producto modelo, IFormFile? imagenArchivo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    if (imagenArchivo != null) modelo.ImagenUrl = await SubirImagen(imagenArchivo);
                    await _productoRepo.UpdateProducto(modelo);

                    // MENSAJE DE ÉXITO
                    TempData["Exito"] = "Producto actualizado con éxito.";
                    return RedirectToAction(nameof(Index));
                }
                catch (Exception ex)
                {
                    TempData["Error"] = "Error al actualizar: " + ex.Message;
                }
            }
            else
            {
                TempData["Error"] = "Hay datos inválidos en el formulario.";
            }

            var categorias = await _productoRepo.ObtenerCategoriasParaSelect();
            ViewBag.Categorias = new Microsoft.AspNetCore.Mvc.Rendering.SelectList(categorias, "Id", "Nombre", modelo.CategoriaId);
            return View(modelo);
        }

        // --- ELIMINAR ---
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Eliminar(int id)
        {
            try
            {
                await _productoRepo.DeleteProducto(id);
                TempData["Exito"] = "Producto eliminado permanentemente.";
            }
            catch (Exception)
            {
                // Esto captura errores si el producto ya está en una venta (Integridad Referencial)
                TempData["Error"] = "No se puede eliminar este producto porque ya tiene ventas asociadas.";
            }
            return RedirectToAction(nameof(Index));
        }

        // Método auxiliar para subir imágenes
        private async Task<string> SubirImagen(IFormFile? archivo)
        {
            if (archivo == null || archivo.Length == 0) return "/imagenes/default.png";

            string carpeta = Path.Combine(_webHostEnvironment.WebRootPath, "imagenes", "productos");
            if (!Directory.Exists(carpeta)) Directory.CreateDirectory(carpeta);

            string nombreArchivo = Guid.NewGuid().ToString() + Path.GetExtension(archivo.FileName);
            string rutaCompleta = Path.Combine(carpeta, nombreArchivo);

            using (var stream = new FileStream(rutaCompleta, FileMode.Create))
            {
                await archivo.CopyToAsync(stream);
            }

            return "/imagenes/productos/" + nombreArchivo;
        }
    }
}