using AlphatechFront.Models;
// Asegúrate de tener este using apuntando a donde creaste la interfaz
// using AlphatechFront.Interfaces; 
using Microsoft.AspNetCore.Mvc;

namespace AlphatechFront.Controllers
{
    public class ProductosController : Controller
    {
        private readonly IProductoRepository _productoRepo;
        private readonly IWebHostEnvironment _webHostEnvironment;

        // Inyectamos el Repositorio (Dapper) y el Entorno (para la ruta de imágenes)
        public ProductosController(IProductoRepository productoRepo, IWebHostEnvironment webHostEnvironment)
        {
            _productoRepo = productoRepo;
            _webHostEnvironment = webHostEnvironment;
        }

        // GET: Productos (Listado usando Dapper)
        public async Task<IActionResult> Index()
        {
            var productos = await _productoRepo.ObtenerProductos();
            return View(productos);
        }

        // GET: Productos/Detalle/5
        public async Task<IActionResult> Detalle(int id)
        {
            var producto = await _productoRepo.ObtenerProductoPorId(id);
            if (producto == null)
            {
                return NotFound();
            }
            return View(producto);
        }

        // GET: Productos/Crear
        public IActionResult Crear()
        {
            // Aquí más adelante cargaremos las Categorías para un DropDownList
            return View();
        }

        // POST: Productos/Crear
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Crear(Producto modelo, IFormFile imagenArchivo)
        {
            if (ModelState.IsValid)
            {
                // Lógica para guardar la imagen
                if (imagenArchivo != null && imagenArchivo.Length > 0)
                {
                    // 1. Definir la ruta: wwwroot/imagenes/productos
                    string carpetaDestino = Path.Combine(_webHostEnvironment.WebRootPath, "imagenes", "productos");

                    // 2. Crear la carpeta si no existe
                    if (!Directory.Exists(carpetaDestino))
                    {
                        Directory.CreateDirectory(carpetaDestino);
                    }

                    // 3. Generar un nombre único para evitar duplicados (ej: ag23-guid.jpg)
                    string nombreArchivo = Guid.NewGuid().ToString() + Path.GetExtension(imagenArchivo.FileName);
                    string rutaCompleta = Path.Combine(carpetaDestino, nombreArchivo);

                    // 4. Guardar el archivo físicamente
                    using (var fileStream = new FileStream(rutaCompleta, FileMode.Create))
                    {
                        await imagenArchivo.CopyToAsync(fileStream);
                    }

                    // 5. Guardar la ruta relativa en el modelo para la Base de Datos
                    modelo.ImagenUrl = "/imagenes/productos/" + nombreArchivo;
                }
                else
                {
                    // Imagen por defecto si no suben nada
                    modelo.ImagenUrl = "/imagenes/default.png";
                }

                // Guardar en SQL Server usando el SP con Dapper
                await _productoRepo.CrearProducto(modelo);

                return RedirectToAction(nameof(Index));
            }
            return View(modelo);
        }
    }
}