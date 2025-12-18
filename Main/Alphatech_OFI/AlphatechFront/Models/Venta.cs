using System;
using System.Collections.Generic;

namespace AlphatechFront.Models
{
    // Cabecera de la Venta
    public class Venta
    {
        public int Id { get; set; }
        public string id_usuario { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Total { get; set; }
        public string Estado { get; set; } // Pendiente, Procesando, Enviado, Cancelado
        public string DireccionEnvio { get; set; }
        public string? CuponAplicado { get; set; }

        // Datos extra para mostrar en la lista (JOINs)
        public string UsuarioNombre { get; set; }
        public string UsuarioEmail { get; set; }
    }

    // Detalle de productos (Renglones)
    public class DetalleVenta
    {
        public int id_producto { get; set; }
        public string ProductoNombre { get; set; }
        public string ProductoImagen { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnitario { get; set; }
        public decimal Subtotal => Cantidad * PrecioUnitario;
    }

    // ViewModel para ver todo junto en la pantalla de "Detalle"
    public class VentaDetalleViewModel
    {
        public Venta Cabecera { get; set; }
        public IEnumerable<DetalleVenta> Detalles { get; set; }
    }
}