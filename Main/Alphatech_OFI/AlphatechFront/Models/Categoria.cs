using System.ComponentModel.DataAnnotations;

namespace AlphatechFront.Models
{
    public class Categoria
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre de la categoría es obligatorio.")]
        [StringLength(50, ErrorMessage = "El nombre no puede superar los 50 caracteres.")]
        [Display(Name = "Nombre de la Categoría")]
        public string Nombre { get; set; }
    }
}