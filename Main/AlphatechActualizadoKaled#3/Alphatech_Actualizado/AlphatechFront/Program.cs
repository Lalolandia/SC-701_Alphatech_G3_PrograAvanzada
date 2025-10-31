using AlphatechFront.Data;
using AlphatechFront.Models;
using AlphatechFront.Services;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
var builder = WebApplication.CreateBuilder(args);


// Add services to the container.
builder.Services.AddControllersWithViews();


// --- MI APORTE (Configuración de la Base de Datos) ---
var _connectionStrings = builder.Configuration.GetConnectionString("MySqlConnection");

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseMySql(_connectionStrings, ServerVersion.AutoDetect(_connectionStrings))
);

builder.Services.AddIdentity<Usuario, IdentityRole>(options =>
{
    // Configuración de las contraseñas
    options.Password.RequireDigit = true;
    options.Password.RequiredLength = 8;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = true;
    options.Password.RequireLowercase = true;

    options.SignIn.RequireConfirmedAccount = false;
    options.SignIn.RequireConfirmedEmail = false;  
    options.SignIn.RequireConfirmedPhoneNumber = false; 
    // Configuración de bloqueo de cuenta
    options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
    options.Lockout.MaxFailedAccessAttempts = 5;
})
    .AddEntityFrameworkStores<ApplicationDbContext>()
    .AddDefaultTokenProviders();

//---MI APORTE(Configuración de Autenticación por Cookies)-- -
//builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
//   .AddCookie(options =>
//   {
//       options.LoginPath = "/Account/Login"; // Página a la que se redirige si no está logueado
//       options.ExpireTimeSpan = TimeSpan.FromMinutes(30);
//       options.SlidingExpiration = true;
//   });


builder.Services.AddCors(
    options =>
    {
        options.AddPolicy("PermitirFrontend", policy =>
        {
            //policy.WithOrigins("https://localhost:7299")
            policy.AllowAnyOrigin()
            .AllowAnyHeader()
            .AllowAnyMethod();

        }
    );
    }

);

var app = builder.Build();

await SeedService.SeedDatabase(app.Services);

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

/*
{
    "ConnectionStrings": {
        "DefaultConnection": "Server=TU_SERVIDOR;Database=AlphatechDB;Trusted_Connection=True;TrustServerCertificate=True;"
    },
  
}
*/
app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Account}/{action=Login}/{id?}");

app.Run();
