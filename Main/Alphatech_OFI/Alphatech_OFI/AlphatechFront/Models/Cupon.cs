using System.ComponentModel.DataAnnotations;

namespace AlphatechFront.Models
{
    public class Cupon
    {
        [Key]
        public int Id { get; set; }
        public string Codigo { get; set; }
        public decimal Descuento { get; set; } // Puede ser un % o un monto fijo
        public DateTime FechaExpiracion { get; set; }
        public bool Activo { get; set; }
    }
}
