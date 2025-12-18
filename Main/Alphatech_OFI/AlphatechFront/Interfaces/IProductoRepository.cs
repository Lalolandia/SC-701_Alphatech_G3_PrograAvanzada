using AlphatechFront.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

public interface IProductoRepository
{
    // Listar todos
    Task<IEnumerable<Producto>> ObtenerProductos();

    // Obtener uno solo (para Editar)
    Task<Producto> ObtenerProductoPorId(int id);

    // Crear
    Task CrearProducto(Producto producto);

    // Editar (Actualizar) - ¡Este te faltaba!
    Task UpdateProducto(Producto producto);

    // Eliminar - ¡Este también!
    Task DeleteProducto(int id);
    Task<IEnumerable<CategoriaSelect>> ObtenerCategoriasParaSelect();
    // Agrega esta línea:
    Task<IEnumerable<Producto>> ObtenerProductosCatalogo(string? busqueda, int? categoriaId);
}