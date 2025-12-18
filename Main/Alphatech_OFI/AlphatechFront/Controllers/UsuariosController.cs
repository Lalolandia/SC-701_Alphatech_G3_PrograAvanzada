using AlphatechFront.Models;
using AlphatechFront.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace AlphatechFront.Controllers
{
    [Authorize(Roles = "Admin")]
    public class UsuariosController : Controller
    {
        private readonly UserManager<Usuario> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;

        public UsuariosController(UserManager<Usuario> userManager, RoleManager<IdentityRole> roleManager)
        {
            _userManager = userManager;
            _roleManager = roleManager;
        }

        // 1. LISTAR
        public async Task<IActionResult> Index()
        {
            var usuarios = await _userManager.Users.ToListAsync();
            var listaUsuarios = new List<UsuarioListaViewModel>();

            foreach (var user in usuarios)
            {
                var roles = await _userManager.GetRolesAsync(user);
                listaUsuarios.Add(new UsuarioListaViewModel
                {
                    Id = user.Id,
                    Nombre = user.NombreCompleto,
                    Email = user.Email,
                    Rol = roles.FirstOrDefault() ?? "Sin Rol"
                });
            }
            return View(listaUsuarios);
        }

        // 2. CREAR (GET)
        public IActionResult Crear()
        {
            ViewBag.Roles = new SelectList(_roleManager.Roles, "Name", "Name");
            return View();
        }

        // 2. CREAR (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Crear(CrearUsuarioViewModel model)
        {
            if (ModelState.IsValid)
            {
                var usuario = new Usuario
                {
                    UserName = model.Email,
                    Email = model.Email,
                    NombreCompleto = model.NombreCompleto,
                    EmailConfirmed = true
                };

                var resultado = await _userManager.CreateAsync(usuario, model.Password);

                if (resultado.Succeeded)
                {
                    if (!string.IsNullOrEmpty(model.Rol))
                    {
                        await _userManager.AddToRoleAsync(usuario, model.Rol);
                    }

                    // ALERTA DE ÉXITO
                    TempData["Exito"] = "Usuario registrado correctamente.";
                    return RedirectToAction(nameof(Index));
                }

                // SI FALLA IDENTITY (Ej: Password débil, correo duplicado)
                string errores = string.Join(", ", resultado.Errors.Select(e => e.Description));
                TempData["Error"] = "Error al crear: " + errores;
            }
            else
            {
                TempData["Error"] = "Hay campos incorrectos en el formulario.";
            }

            ViewBag.Roles = new SelectList(_roleManager.Roles, "Name", "Name");
            return View(model);
        }

        // 3. EDITAR (GET)
        public async Task<IActionResult> Editar(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user == null) return NotFound();

            var roles = await _userManager.GetRolesAsync(user);
            var model = new EditarUsuarioViewModel
            {
                Id = user.Id,
                NombreCompleto = user.NombreCompleto,
                Email = user.Email,
                Rol = roles.FirstOrDefault()
            };

            ViewBag.Roles = new SelectList(_roleManager.Roles, "Name", "Name", model.Rol);
            return View(model);
        }

        // 3. EDITAR (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Editar(EditarUsuarioViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = await _userManager.FindByIdAsync(model.Id);
                if (user == null) return NotFound();

                user.NombreCompleto = model.NombreCompleto;
                user.Email = model.Email;
                user.UserName = model.Email; // Actualizamos también el username

                var result = await _userManager.UpdateAsync(user);

                if (result.Succeeded)
                {
                    // Actualizar Rol
                    var rolesViejos = await _userManager.GetRolesAsync(user);
                    if (rolesViejos.Any()) await _userManager.RemoveFromRolesAsync(user, rolesViejos);

                    if (!string.IsNullOrEmpty(model.Rol)) await _userManager.AddToRoleAsync(user, model.Rol);

                    TempData["Exito"] = "Datos del usuario actualizados.";
                    return RedirectToAction(nameof(Index));
                }

                string errores = string.Join(", ", result.Errors.Select(e => e.Description));
                TempData["Error"] = "No se pudo actualizar: " + errores;
            }
            else
            {
                TempData["Error"] = "Verifica los datos ingresados.";
            }

            ViewBag.Roles = new SelectList(_roleManager.Roles, "Name", "Name", model.Rol);
            return View(model);
        }

        // 4. ELIMINAR (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Eliminar(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user != null)
            {
                // Validación extra: No borrar al propio admin logueado
                if (User.Identity.Name == user.UserName)
                {
                    TempData["Error"] = "No puedes eliminar tu propia cuenta mientras estás logueado.";
                    return RedirectToAction(nameof(Index));
                }

                await _userManager.DeleteAsync(user);
                TempData["Exito"] = "Usuario eliminado del sistema.";
            }
            else
            {
                TempData["Error"] = "El usuario no existe.";
            }
            return RedirectToAction(nameof(Index));
        }
    }
}