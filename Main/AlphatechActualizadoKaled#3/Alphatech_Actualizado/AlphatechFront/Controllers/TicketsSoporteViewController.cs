using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace AlphatechFront.Controllers
{
    // [Authorize]
    public class TicketsSoporteViewController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
