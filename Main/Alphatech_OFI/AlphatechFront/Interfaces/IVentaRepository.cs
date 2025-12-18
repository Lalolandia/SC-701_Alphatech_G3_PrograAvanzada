using AlphatechFront.Models;

public interface IVentaRepository
{
    Task<IEnumerable<Venta>> ObtenerVentas();
    Task<Venta> ObtenerVentaPorId(int id);
    Task<IEnumerable<DetalleVenta>> ObtenerDetallesDeVenta(int idVenta);
    Task ActualizarEstadoVenta(int idVenta, string nuevoEstado);
}