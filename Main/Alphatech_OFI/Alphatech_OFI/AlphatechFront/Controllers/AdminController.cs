using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace AlphatechFront.Controllers
{
    //[Authorize(Roles = "Admin,Administrador")] // <-- Descomenta esto cuando ya tengas el Login funcionando para proteger el panel
    public class AdminController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}