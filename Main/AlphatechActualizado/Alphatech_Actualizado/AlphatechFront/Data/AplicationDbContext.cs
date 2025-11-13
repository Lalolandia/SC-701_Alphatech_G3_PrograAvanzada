using AlphatechFront.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace AlphatechFront.Data
{
    // TAREA PARA COMPAÑEROS:
    
    // Este archivo es el "puente" con la base de datos.
    // Deben agregar aquí un 'DbSet' por cada modelo que creen
    // para que Entity Framework pueda administrar sus tablas.
    public class ApplicationDbContext : IdentityDbContext<Usuario>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }

        // --- DbSets existentes (basado en los controladores) ---
        // NOTA: Deben crear los modelos para cada uno de estos.
       //  public DbSet<Producto> Productos { get; set; }
       //  public DbSet<Categoria> Categorias { get; set; }
        // public DbSet<Venta> Ventas { get; set; }
        // public DbSet<DetalleVenta> DetalleVentas { get; set; }
       //  public DbSet<Carrito> Carritos { get; set; }
        // public DbSet<Rol> Roles { get; set; }


        // --- DbSets para las nuevas funcionalidades ---
        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Cupon> Cupones { get; set; }
        public DbSet<Notificacion> Notificaciones { get; set; }
        public DbSet<TicketSoporte> TicketsSoporte { get; set; }
    }
}
