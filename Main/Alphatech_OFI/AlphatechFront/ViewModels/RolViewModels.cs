using System.ComponentModel.DataAnnotations;

namespace AlphatechFront.ViewModels
{
    public class RolViewModel
    {
        // El signo de interrogación ? permite que sea nulo al crear
        public string? Id { get; set; }

        [Required(ErrorMessage = "Debes escribir un nombre para el rol.")]
        [StringLength(50, ErrorMessage = "El nombre es demasiado largo.")]
        [Display(Name = "Nombre del Rol")]
        public string Nombre { get; set; }
    }
}