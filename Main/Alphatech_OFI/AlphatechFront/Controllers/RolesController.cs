using AlphatechFront.Models; // Para Usuario
using AlphatechFront.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AlphatechFront.Controllers
{
    [Authorize(Roles = "Admin")]
    public class RolesController : Controller
    {
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly UserManager<Usuario> _userManager;

        public RolesController(RoleManager<IdentityRole> roleManager, UserManager<Usuario> userManager)
        {
            _roleManager = roleManager;
            _userManager = userManager;
        }

        // 1. LISTAR
        public async Task<IActionResult> Index()
        {
            var roles = await _roleManager.Roles.ToListAsync();
            return View(roles);
        }

        // 2. CREAR (GET)
        public IActionResult Crear()
        {
            return View();
        }

        // 2. CREAR (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Crear(RolViewModel model)
        {
            if (ModelState.IsValid)
            {
                // Validar duplicados
                if (await _roleManager.RoleExistsAsync(model.Nombre))
                {
                    TempData["Error"] = $"El rol '{model.Nombre}' ya existe.";
                    return View(model);
                }

                await _roleManager.CreateAsync(new IdentityRole(model.Nombre));

                TempData["Exito"] = "Rol creado exitosamente.";
                return RedirectToAction(nameof(Index));
            }
            return View(model);
        }

        // 3. EDITAR (GET)
        public async Task<IActionResult> Editar(string id)
        {
            var rol = await _roleManager.FindByIdAsync(id);
            if (rol == null) return NotFound();

            return View(new RolViewModel { Id = rol.Id, Nombre = rol.Name });
        }

        // 3. EDITAR (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Editar(RolViewModel model)
        {
            if (ModelState.IsValid)
            {
                var rol = await _roleManager.FindByIdAsync(model.Id);
                if (rol == null)
                {
                    TempData["Error"] = "El rol no existe.";
                    return RedirectToAction(nameof(Index));
                }

                // Protección: No renombrar Admin
                if (rol.Name == "Admin" || rol.Name == "Administrador")
                {
                    TempData["Error"] = "No puedes editar el nombre del rol Administrador principal.";
                    return RedirectToAction(nameof(Index));
                }

                rol.Name = model.Nombre;
                var resultado = await _roleManager.UpdateAsync(rol);

                if (resultado.Succeeded)
                {
                    TempData["Exito"] = "Nombre del rol actualizado.";
                    return RedirectToAction(nameof(Index));
                }

                TempData["Error"] = "Error al actualizar.";
            }
            return View(model);
        }

        // 4. ELIMINAR (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Eliminar(string id)
        {
            var rol = await _roleManager.FindByIdAsync(id);
            if (rol == null)
            {
                TempData["Error"] = "El rol no fue encontrado.";
                return RedirectToAction(nameof(Index));
            }

            // 1. Protección: No borrar Admin
            if (rol.Name == "Admin" || rol.Name == "Administrador")
            {
                TempData["Error"] = "¡Acción denegada! No puedes eliminar el rol de Administrador.";
                return RedirectToAction(nameof(Index));
            }

            // 2. Protección: No borrar si hay usuarios usándolo
            var usuariosEnRol = await _userManager.GetUsersInRoleAsync(rol.Name);
            if (usuariosEnRol.Count > 0)
            {
                TempData["Error"] = $"No se puede eliminar: Hay {usuariosEnRol.Count} usuarios usando este rol actualmente.";
                return RedirectToAction(nameof(Index));
            }

            await _roleManager.DeleteAsync(rol);
            TempData["Exito"] = "Rol eliminado correctamente.";
            return RedirectToAction(nameof(Index));
        }
    }
}