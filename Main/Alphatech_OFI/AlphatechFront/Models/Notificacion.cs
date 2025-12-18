using System.ComponentModel.DataAnnotations;

namespace AlphatechFront.Models
{
    public class Notificacion
    {
        public int Id { get; set; }

        // IMPORTANTE: Aquí debe decir UsuarioId para coincidir con el Controller
        public string UsuarioId { get; set; }

        public string Mensaje { get; set; }
        public string Url { get; set; } // A dónde te lleva al hacer click
        public bool Leida { get; set; } = false;
        public DateTime Fecha { get; set; } = DateTime.Now;
    }
}