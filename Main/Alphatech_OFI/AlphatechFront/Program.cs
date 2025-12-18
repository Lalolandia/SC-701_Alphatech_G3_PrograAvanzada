using AlphatechFront.Data;
using AlphatechFront.Interfaces;

// using AlphatechFront.Interfaces; // <-- Probablemente tus interfaces están en Repositories, si no, descomenta esta línea.
using AlphatechFront.Models;
using AlphatechFront.Repositories;
using AlphatechFront.Services; // <--- NECESARIO PARA EMAILSERVICE
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;

var builder = WebApplication.CreateBuilder(args);

// 1. Agregar soporte para Vistas y Controladores
builder.Services.AddControllersWithViews();

// 2. Configuración de Base de Datos (Entity Framework)
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString)
);

// 3. Configuración de Dapper (Singleton porque solo guarda la cadena de conexión)
builder.Services.AddSingleton<DapperContext>();

// 4. Configuración de Identity (Usuarios y Roles)
builder.Services.AddIdentity<Usuario, IdentityRole>(options =>
{
    // Reglas de contraseña
    options.Password.RequireDigit = true;
    options.Password.RequiredLength = 8;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = true;
    options.Password.RequireLowercase = true;

    // Configuración de Login
    options.SignIn.RequireConfirmedAccount = false;
    options.SignIn.RequireConfirmedEmail = false;
    options.SignIn.RequireConfirmedPhoneNumber = false;

    // Bloqueo por intentos fallidos
    options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
    options.Lockout.MaxFailedAccessAttempts = 5;
})
.AddEntityFrameworkStores<ApplicationDbContext>()
.AddDefaultTokenProviders();

// 5. Configuración de CORS (Opcional, útil si conectas apps externas)
builder.Services.AddCors(options =>
{
    options.AddPolicy("PermitirFrontend", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

// --- ZONA DE INYECCIÓN DE DEPENDENCIAS (SERVICIOS Y REPOSITORIOS) ---

// Repositorios (Dapper)
builder.Services.AddScoped<IProductoRepository, ProductoRepository>();
builder.Services.AddScoped<ICategoriaRepository, CategoriaRepository>();
builder.Services.AddScoped<IVentaRepository, VentaRepository>();

// Servicios de Lógica (Email, etc.)
builder.Services.AddTransient<EmailService>(); // <--- ESTO ARREGLA TU ERROR ACTUAL

// --------------------------------------------------------------------

var app = builder.Build();

// Ejecutar Semillas de Datos (Crear Admin por defecto si existe la clase)
// Asegúrate de que tu SeedService maneje errores por si la BD no está lista
try
{
    await SeedService.SeedDatabase(app.Services);
}
catch (Exception ex)
{
    Console.WriteLine("Error al ejecutar SeedService: " + ex.Message);
}

// Configuración del Pipeline de Peticiones HTTP
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication(); // 1. Identificar quién es
app.UseAuthorization();  // 2. Ver qué permisos tiene

// Ruta por defecto
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Account}/{action=Login}/{id?}"); // Inicia en Login

app.Run();