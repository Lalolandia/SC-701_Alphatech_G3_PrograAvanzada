using AlphatechFront.Data;
using AlphatechFront.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace AlphatechFront.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CuponesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public CuponesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/cupones
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Cupon>>> GetCupones()
        {
            return await _context.Cupones.ToListAsync();
        }

        // GET: api/cupones/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Cupon>> GetCupon(int id)
        {
            var cupon = await _context.Cupones.FindAsync(id);

            if (cupon == null)
                return NotFound();

            return cupon;
        }

        // GET: api/cupones/validar/CODIGO123
        [HttpGet("validar/{codigo}")]
        public async Task<ActionResult<Cupon>> ValidarCupon(string codigo)
        {
            var cupon = await _context.Cupones
                .FirstOrDefaultAsync(c => c.Codigo == codigo && c.Activo);

            if (cupon == null)
                return NotFound(new { mensaje = "Cupón inválido o inactivo" });

            if (cupon.FechaExpiracion < DateTime.Now)
                return BadRequest(new { mensaje = "Cupón expirado" });

            return Ok(cupon);
        }

        // POST: api/cupones
        [HttpPost]
        public async Task<ActionResult<Cupon>> PostCupon(Cupon cupon)
        {
            _context.Cupones.Add(cupon);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCupon), new { id = cupon.Id }, cupon);
        }

        // PUT: api/cupones/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCupon(int id, Cupon cupon)
        {
            if (id != cupon.Id)
                return BadRequest();

            _context.Entry(cupon).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CuponExists(id))
                    return NotFound();
                else
                    throw;
            }

            return NoContent();
        }

        // DELETE: api/cupones/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCupon(int id)
        {
            var cupon = await _context.Cupones.FindAsync(id);
            if (cupon == null)
                return NotFound();

            _context.Cupones.Remove(cupon);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CuponExists(int id)
        {
            return _context.Cupones.Any(e => e.Id == id);
        }
    }
}
