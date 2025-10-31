using System.ComponentModel.DataAnnotations;

namespace AlphatechFront.Models
{
    public class Notificacion
    {
        [Key]
        public int Id { get; set; }
        public int UsuarioId { get; set; } // A qué usuario pertenece
        public string Mensaje { get; set; }
        public DateTime Fecha { get; set; }
        public bool Leida { get; set; }
        public string Url { get; set; } // Opcional: para redirigir al hacer clic
    }
}
