using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AlphatechFront.Models
{
    public class Producto
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre es obligatorio.")]
        [StringLength(100, ErrorMessage = "El nombre no puede tener más de 100 caracteres.")]
        public string Nombre { get; set; }

        [Required(ErrorMessage = "La descripción es obligatoria.")]
        public string Descripcion { get; set; }

        [Required(ErrorMessage = "El precio es obligatorio.")]
        [Range(1, 10000000, ErrorMessage = "El precio debe ser mayor a 0.")]
        [DisplayFormat(DataFormatString = "{0:N2}")] // Formato visual 1,500.00
        public decimal Precio { get; set; }

        [Required(ErrorMessage = "El stock es obligatorio.")]
        [Range(0, 10000, ErrorMessage = "El stock no puede ser negativo.")]
        public int Stock { get; set; }

        [Display(Name = "Imagen de Portada")]
        public string? ImagenUrl { get; set; }

        [Required(ErrorMessage = "Debes seleccionar una categoría.")]
        [Display(Name = "Categoría")]
        public int CategoriaId { get; set; }

        public string? CategoriaNombre { get; set; }
    }

    // Tu clase auxiliar CategoriaSelect sigue igual aquí abajo...
    public class CategoriaSelect
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
    }
}