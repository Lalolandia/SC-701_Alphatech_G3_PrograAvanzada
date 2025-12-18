using AlphatechFront.Data;
using AlphatechFront.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore; // Necesario para ToListAsync
using System.Security.Claims;

namespace AlphatechFront.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize] // Solo usuarios logueados pueden usar esto
    public class NotificacionesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public NotificacionesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/notificaciones
        // Obtiene todas las notificaciones del usuario actual
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Notificacion>>> GetNotificaciones()
        {
            // 1. Obtener ID del usuario logueado
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userId)) return Unauthorized();

            // 2. Filtrar usando 'UsuarioId' (Correcto)
            var notificaciones = await _context.Notificaciones
                .Where(n => n.UsuarioId == userId)
                .OrderByDescending(n => n.Fecha)
                .ToListAsync();

            return Ok(notificaciones);
        }

        // PUT: api/notificaciones/marcarleidas
        // Marca como leídas una lista específica de IDs (ej: [1, 5, 8])
        [HttpPut("marcarleidas")]
        public async Task<IActionResult> MarcarLeidas([FromBody] List<int> ids)
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userId)) return Unauthorized();

            // 1. Buscamos las notificaciones que coincidan con los IDs Y que pertenezcan al usuario
            var notificaciones = await _context.Notificaciones
                .Where(n => ids.Contains(n.Id) && n.UsuarioId == userId) // CORREGIDO AQUÍ
                .ToListAsync();

            if (!notificaciones.Any()) return NotFound();

            // 2. Actualizamos el estado
            foreach (var n in notificaciones)
            {
                n.Leida = true;
            }

            // 3. Guardamos cambios en BD
            await _context.SaveChangesAsync();
            return NoContent();
        }

        // PUT: api/notificaciones/marcartodas
        // Marca todo como leído de un solo golpe
        [HttpPut("marcartodas")]
        public async Task<IActionResult> MarcarTodas()
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userId)) return Unauthorized();

            // 1. Buscar todas las NO leídas de este usuario
            var notificaciones = await _context.Notificaciones
                .Where(n => n.UsuarioId == userId && !n.Leida)
                .ToListAsync();

            if (!notificaciones.Any()) return NoContent(); // Nada que actualizar

            // 2. Actualizar
            foreach (var n in notificaciones)
            {
                n.Leida = true;
            }

            // 3. Guardar
            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}