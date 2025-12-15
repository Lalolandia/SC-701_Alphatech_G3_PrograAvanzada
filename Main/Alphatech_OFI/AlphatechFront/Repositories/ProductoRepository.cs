// Repositories/ProductoRepository.cs
using AlphatechFront.Models;
using Dapper;
using System.Data;

public class ProductoRepository : IProductoRepository
{
    private readonly DapperContext _context;

    public ProductoRepository(DapperContext context)
    {
        _context = context; // Inyección del contexto de BD
    }

    public async Task<IEnumerable<Producto>> ObtenerProductos()
    {
        using (var connection = _context.CreateConnection())
        {
            // Llama al SP creado en el paso 2
            return await connection.QueryAsync<Producto>("sp_ObtenerProductos", commandType: CommandType.StoredProcedure);
        }
    }

    public async Task CrearProducto(Producto producto)
    {
        using (var connection = _context.CreateConnection())
        {
            var parameters = new DynamicParameters();
            parameters.Add("Nombre", producto.Nombre);
            parameters.Add("Descripcion", producto.Descripcion);
            parameters.Add("Precio", producto.Precio);
            parameters.Add("Stock", producto.Stock);
            parameters.Add("ImagenUrl", producto.ImagenUrl);
            parameters.Add("CategoriaId", producto.CategoriaId); // Asegúrate que tu modelo tenga esta propiedad

            await connection.ExecuteAsync("sp_InsertarProducto", parameters, commandType: CommandType.StoredProcedure);
        }
    }
    public async Task<Producto> ObtenerProductoPorId(int id)
    {
        using (var connection = _context.CreateConnection())
        {
            // QuerySingleOrDefaultAsync se usa cuando esperas solo 1 resultado
            return await connection.QuerySingleOrDefaultAsync<Producto>(
                "sp_ObtenerProductoPorId",
                new { Id = id },
                commandType: CommandType.StoredProcedure
            );
        }
    }
}