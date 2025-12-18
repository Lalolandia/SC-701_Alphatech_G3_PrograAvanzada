using System.ComponentModel.DataAnnotations;

namespace AlphatechFront.ViewModels
{
    public class CrearUsuarioViewModel
    {
        [Required(ErrorMessage = "El nombre es obligatorio.")]
        [Display(Name = "Nombre Completo")]
        public string NombreCompleto { get; set; }

        [Required(ErrorMessage = "El correo es obligatorio.")]
        [EmailAddress(ErrorMessage = "Ingresa un correo válido.")]
        public string Email { get; set; }

        [Required(ErrorMessage = "La contraseña es obligatoria.")]
        [DataType(DataType.Password)]
        [StringLength(100, ErrorMessage = "La {0} debe tener al menos {2} caracteres.", MinimumLength = 6)]
        public string Password { get; set; }

        [Required(ErrorMessage = "Debes asignar un rol al usuario.")]
        [Display(Name = "Rol Asignado")]
        public string Rol { get; set; }
    }

    public class EditarUsuarioViewModel
    {
        public string Id { get; set; }

        [Required(ErrorMessage = "El nombre no puede quedar vacío.")]
        [Display(Name = "Nombre Completo")]
        public string NombreCompleto { get; set; }

        [Required(ErrorMessage = "El correo es obligatorio.")]
        [EmailAddress(ErrorMessage = "El formato del correo no es correcto.")]
        public string Email { get; set; }

        [Display(Name = "Rol Asignado")]
        public string Rol { get; set; }
    }

    // El UsuarioListaViewModel se queda igual
    public class UsuarioListaViewModel
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public string Email { get; set; }
        public string Rol { get; set; }
    }
}