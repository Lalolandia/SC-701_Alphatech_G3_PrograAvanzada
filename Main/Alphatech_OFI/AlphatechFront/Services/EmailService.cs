using System.Net;
using System.Net.Mail;

namespace AlphatechFront.Services
{
    public class EmailService
    {
        private readonly IConfiguration _configuration;

        // Inyectamos IConfiguration para leer appsettings.json
        public EmailService(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public void EnviarCorreo(string destino, string asunto, string mensaje)
        {
            // Leemos los valores del JSON
            string host = _configuration["EmailSettings:Host"];
            int port = int.Parse(_configuration["EmailSettings:Port"]);
            string emailOrigen = _configuration["EmailSettings:Email"];
            string password = _configuration["EmailSettings:Password"];

            // Validación rápida para evitar el error que te salió
            if (string.IsNullOrEmpty(host) || string.IsNullOrEmpty(emailOrigen))
            {
                // Si no hay configuración, no hacemos nada (o podrías lanzar un error controlado)
                // Esto evita que la app se rompa si olvidas configurar el correo
                return;
            }

            var smtpClient = new SmtpClient(host)
            {
                Port = port,
                Credentials = new NetworkCredential(emailOrigen, password),
                EnableSsl = true,
            };

            var mailMessage = new MailMessage
            {
                From = new MailAddress(emailOrigen, "Alphatech Soporte"),
                Subject = asunto,
                Body = mensaje,
                IsBodyHtml = true,
            };

            mailMessage.To.Add(destino);

            try
            {
                smtpClient.Send(mailMessage);
            }
            catch (Exception ex)
            {
                // Si falla el envío (ej: firewall bloquea), lo atrapamos aquí 
                // para que no rompa el registro del usuario.
                Console.WriteLine("No se pudo enviar el correo: " + ex.Message);
            }
        }
    }
}