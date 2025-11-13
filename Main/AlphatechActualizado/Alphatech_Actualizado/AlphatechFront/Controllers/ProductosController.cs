using Microsoft.AspNetCore.Mvc;

namespace AlphatechFront.Controllers
{
    public class ProductosController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Detalle(int id)
        {
            ViewBag.ProductoId = id;
            return View(id); 
        }
    }
}
