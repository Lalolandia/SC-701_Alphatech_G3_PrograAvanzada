using Microsoft.AspNetCore.Authorization; // Importante para proteger la página
using Microsoft.AspNetCore.Mvc;

namespace AlphatechFront.Controllers
{
    // [Authorize] // Descomenta esto para que solo usuarios logueados puedan ver esta página
    public class CuponesViewController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
