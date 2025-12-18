using AlphatechFront.Models;
using AlphatechFront.ViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using AlphatechFront.Services;

namespace AlphatechFront.Controllers
{
    public class AccountController : Controller
    {
        private readonly SignInManager<Usuario> signInManager;
        private readonly UserManager<Usuario> userManager;
        private readonly RoleManager<IdentityRole> roleManager;
        private readonly EmailService emailService;

        public AccountController(
            SignInManager<Usuario> signInManager,
            UserManager<Usuario> userManager,
            RoleManager<IdentityRole> roleManager,
            EmailService emailService)
        {
            this.signInManager = signInManager;
            this.userManager = userManager;
            this.roleManager = roleManager;
            this.emailService = emailService;
        }

        // ================= LOGIN =================

        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(LoginViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            var result = await signInManager.PasswordSignInAsync(
                model.Email,
                model.Password,
                model.RememberMe,
                false
            );

            if (result.Succeeded)
            {
                var usuario = await userManager.FindByEmailAsync(model.Email);

                // 📧 CORREO DE BIENVENIDA
                emailService.EnviarCorreo(
                    usuario.Email,
                    "👋 Bienvenido a Alphatech",
                    $@"
                    <h2>Hola {usuario.NombreCompleto}</h2>
                    <p>Has iniciado sesión correctamente.</p>
                    <p>Si no fuiste tú, por favor contáctanos.</p>
                    <br/>
                    <strong>Equipo Alphatech</strong>"
                );

                return RedirectToAction("Index", "Home");
            }

            ModelState.AddModelError("", "Usuario o contraseña incorrectos.");
            return View(model);
        }

        // ================= REGISTRO =================

        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            Usuario usuario = new Usuario
            {
                NombreCompleto = model.NombreCompleto,
                Email = model.Email,
                UserName = model.Email
            };

            var result = await userManager.CreateAsync(usuario, model.Password);

            if (result.Succeeded)
            {
                if (!await roleManager.RoleExistsAsync("User"))
                    await roleManager.CreateAsync(new IdentityRole("User"));

                await userManager.AddToRoleAsync(usuario, "User");
                await signInManager.SignInAsync(usuario, false);

                // 📧 CORREO DE REGISTRO
                emailService.EnviarCorreo(
                    usuario.Email,
                    "🎉 Cuenta creada en Alphatech",
                    $@"
                    <h2>Bienvenido {usuario.NombreCompleto}</h2>
                    <p>Tu cuenta fue creada exitosamente.</p>
                    <p>Ya puedes iniciar sesión cuando quieras.</p>
                    <br/>
                    <strong>Equipo Alphatech</strong>"
                );

                return RedirectToAction("Index", "Home");
            }

            foreach (var error in result.Errors)
                ModelState.AddModelError("", error.Description);

            return View(model);
        }

        // ================= RECUPERAR CONTRASEÑA =================

        public IActionResult VerifyEmail()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> VerifyEmail(VerifyEmailViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            var user = await userManager.FindByEmailAsync(model.Email);

            if (user == null)
            {
                ModelState.AddModelError("", "Email no encontrado.");
                return View(model);
            }

            // 📧 CORREO EMAIL VERIFICADO
            emailService.EnviarCorreo(
                user.Email,
                "📧 Verificación de correo",
                $@"
                <h2>Hola {user.NombreCompleto}</h2>
                <p>Tu correo fue verificado correctamente.</p>
                <p>Ahora puedes cambiar tu contraseña.</p>
                <br/>
                <strong>Equipo Alphatech</strong>"
            );

            return RedirectToAction("ChangePassword", new { username = user.UserName });
        }

        public IActionResult ChangePassword(string username)
        {
            if (string.IsNullOrEmpty(username))
                return RedirectToAction("VerifyEmail");

            return View(new ChangePasswordViewModel { Email = username });
        }

        [HttpPost]
        public async Task<IActionResult> ChangePassword(ChangePasswordViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            var user = await userManager.FindByEmailAsync(model.Email);

            if (user == null)
            {
                ModelState.AddModelError("", "Usuario no encontrado.");
                return View(model);
            }

            await userManager.RemovePasswordAsync(user);
            await userManager.AddPasswordAsync(user, model.NewPassword);

            // 📧 CORREO CONTRASEÑA CAMBIADA
            emailService.EnviarCorreo(
                user.Email,
                "🔐 Contraseña cambiada",
                $@"
                <h2>Hola {user.NombreCompleto}</h2>
                <p>Tu contraseña fue cambiada exitosamente.</p>
                <p>Si no realizaste este cambio, contáctanos inmediatamente.</p>
                <br/>
                <strong>Equipo Alphatech</strong>"
            );

            return RedirectToAction("Login");
        }

        // ================= LOGOUT =================

        public async Task<IActionResult> Logout()
        {
            var user = await userManager.GetUserAsync(User);

            if (user != null)
            {
                // 📧 CORREO CIERRE DE SESIÓN (opcional)
                emailService.EnviarCorreo(
                    user.Email,
                    "👋 Sesión cerrada",
                    $@"
                    <h2>Hola {user.NombreCompleto}</h2>
                    <p>Has cerrado sesión correctamente.</p>
                    <br/>
                    <strong>Equipo Alphatech</strong>"
                );
            }

            await signInManager.SignOutAsync();
            return RedirectToAction("Login");
        }
    }
}