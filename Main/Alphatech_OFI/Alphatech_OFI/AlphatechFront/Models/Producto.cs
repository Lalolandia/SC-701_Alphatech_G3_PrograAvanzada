using System.ComponentModel.DataAnnotations;

namespace AlphatechFront.Models
{
    public class Producto
    {
        public int Id { get; set; } // En SQL es id_producto

        [Required(ErrorMessage = "El nombre es obligatorio")]
        public string Nombre { get; set; }

        public string Descripcion { get; set; }

        [Required]
        public decimal Precio { get; set; }

        [Required]
        public int Stock { get; set; }

        public string? ImagenUrl { get; set; } // Puede ser nulo

        [Required]
        public int CategoriaId { get; set; }
        public string? CategoriaNombre { get; set; }
    }
    public class CategoriaSelect
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
    }
}