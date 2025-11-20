using AlphatechFront.Data;
using AlphatechFront.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace AlphatechFront.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize] // Solo usuarios autenticados pueden acceder
    public class NotificacionesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public NotificacionesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/notificaciones
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Notificacion>>> GetNotificaciones()
        {
            // Obtener el Id del usuario logueado desde los claims
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userId))
                return Unauthorized();

            int usuarioId = int.Parse(userId);

            var notificaciones = _context.Notificaciones
                .Where(n => n.UsuarioId == usuarioId)
                .OrderByDescending(n => n.Fecha)
                .ToList();

            return Ok(notificaciones);
        }

        // PUT: api/notificaciones/marcarleidas
        [HttpPut("marcarleidas")]
        public async Task<IActionResult> MarcarLeidas([FromBody] List<int> ids)
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userId))
                return Unauthorized();

            int usuarioId = int.Parse(userId);

            var notificaciones = _context.Notificaciones
                .Where(n => ids.Contains(n.Id) && n.UsuarioId == usuarioId)
                .ToList();

            if (!notificaciones.Any())
                return NotFound();

            foreach (var n in notificaciones)
                n.Leida = true;

            await _context.SaveChangesAsync();
            return NoContent();
        }

        // PUT: api/notificaciones/marcartodas
        [HttpPut("marcartodas")]
        public async Task<IActionResult> MarcarTodas()
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userId))
                return Unauthorized();

            int usuarioId = int.Parse(userId);

            var notificaciones = _context.Notificaciones
                .Where(n => n.UsuarioId == usuarioId && !n.Leida)
                .ToList();

            foreach (var n in notificaciones)
                n.Leida = true;

            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}


