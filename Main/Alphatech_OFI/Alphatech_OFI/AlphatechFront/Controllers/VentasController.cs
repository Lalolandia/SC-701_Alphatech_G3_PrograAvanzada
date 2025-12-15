using Microsoft.AspNetCore.Mvc;

namespace AlphatechFront.Controllers
{
    public class VentasController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}