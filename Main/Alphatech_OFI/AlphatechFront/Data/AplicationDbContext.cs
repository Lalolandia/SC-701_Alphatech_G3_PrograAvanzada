using AlphatechFront.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace AlphatechFront.Data
{
    public class ApplicationDbContext : IdentityDbContext<Usuario>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        // Tus tablas
        public DbSet<Producto> Productos { get; set; }
        public DbSet<Cupon> Cupones { get; set; }
        public DbSet<Notificacion> Notificaciones { get; set; }
        public DbSet<TicketSoporte> TicketsSoporte { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Mapear Producto a tabla "productos"
            modelBuilder.Entity<Producto>()
                .ToTable("productos");
        }
    }
}