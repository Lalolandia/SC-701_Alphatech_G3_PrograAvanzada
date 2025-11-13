using Microsoft.AspNetCore.Mvc;

namespace AlphatechFront.Controllers
{
    public class CarritoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}