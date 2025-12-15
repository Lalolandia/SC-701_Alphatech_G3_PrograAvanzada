using Microsoft.AspNetCore.Identity;

namespace AlphatechFront.Models
{
    // Es OBLIGATORIO que herede de IdentityUser
    public class Usuario : IdentityUser
    {
        // Tus propiedades extra
        public string NombreCompleto { get; set; }
        public string? Rol { get; set; }
        // No agregues Id, Email o Password aquí, IdentityUser ya los trae
    }
}
