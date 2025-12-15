// Interfaces/IProductoRepository.cs
using AlphatechFront.Models; // Asegúrate de usar tu namespace correcto

public interface IProductoRepository
{
    Task<IEnumerable<Producto>> ObtenerProductos();
    Task CrearProducto(Producto producto);
    Task<Producto> ObtenerProductoPorId(int id);
}