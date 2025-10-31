using System.ComponentModel.DataAnnotations;

namespace AlphatechFront.Models
{
    public enum EstadoTicket
    {
        Abierto,
        EnProceso,
        Cerrado
    }

    public class TicketSoporte
    {
        [Key]
        public int Id { get; set; }
        public int UsuarioId { get; set; }
        public string Asunto { get; set; }
        public string Descripcion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public EstadoTicket Estado { get; set; }
    }
}
