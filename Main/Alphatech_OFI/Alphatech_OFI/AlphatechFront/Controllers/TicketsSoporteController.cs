using AlphatechFront.Models;
using Microsoft.AspNetCore.Mvc;
// ... usings
[Route("api/[controller]")]
[ApiController]
public class TicketsSoporteController : ControllerBase
{
    // GET: api/ticketssoporte
    [HttpGet]
    public async Task<ActionResult<IEnumerable<TicketSoporte>>> GetTickets()
    {
        // Lógica para obtener tickets del usuario actual
        return Ok(new List<TicketSoporte>());
    }

    // GET: api/ticketssoporte/5
    [HttpGet("{id}")]
    public async Task<ActionResult<TicketSoporte>> GetTicket(int id)
    {
        return Ok(new TicketSoporte { Id = id, Asunto = "Test Ticket" });
    }

    // POST: api/ticketssoporte
    [HttpPost]
    public async Task<ActionResult<TicketSoporte>> PostTicket(TicketSoporte ticket)
    {
        // Lógica para crear un nuevo ticket
        return CreatedAtAction(nameof(GetTicket), new { id = ticket.Id }, ticket);
    }
}
