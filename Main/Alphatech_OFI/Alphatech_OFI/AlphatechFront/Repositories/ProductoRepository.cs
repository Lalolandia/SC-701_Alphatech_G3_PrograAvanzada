using AlphatechFront.Data;
using AlphatechFront.Models;
using Dapper;
using System.Data;

namespace AlphatechFront.Repositories
{
    public class ProductoRepository : IProductoRepository
    {
        private readonly DapperContext _context;

        public ProductoRepository(DapperContext context)
        {
            _context = context;
        }

        // 1. LISTAR PRODUCTOS (Con el Nombre de la Categoría)
        public async Task<IEnumerable<Producto>> ObtenerProductos()
        {
            // Usamos INNER JOIN para traer 'nombre_categoria' y lo guardamos en 'CategoriaNombre'
            var query = @"
                SELECT 
                    p.id_producto as Id, 
                    p.nombre as Nombre, 
                    p.descripcion as Descripcion, 
                    p.precio as Precio, 
                    p.stock as Stock, 
                    p.imagen_url as ImagenUrl, 
                    p.categoria_id as CategoriaId,
                    c.nombre_categoria as CategoriaNombre 
                FROM productos p
                INNER JOIN categorias c ON p.categoria_id = c.id_categoria";

            using (var connection = _context.CreateConnection())
            {
                return await connection.QueryAsync<Producto>(query);
            }
        }

        // 2. OBTENER UN SOLO PRODUCTO (Para Editar)
        public async Task<Producto> ObtenerProductoPorId(int id)
        {
            var query = @"
                SELECT 
                    id_producto as Id, 
                    nombre as Nombre, 
                    descripcion as Descripcion, 
                    precio as Precio, 
                    stock as Stock, 
                    imagen_url as ImagenUrl, 
                    categoria_id as CategoriaId 
                FROM productos 
                WHERE id_producto = @Id";

            using (var connection = _context.CreateConnection())
            {
                return await connection.QuerySingleOrDefaultAsync<Producto>(query, new { Id = id });
            }
        }

        // 3. CREAR PRODUCTO
        public async Task CrearProducto(Producto producto)
        {
            var query = @"
                INSERT INTO productos (nombre, descripcion, precio, stock, imagen_url, categoria_id) 
                VALUES (@Nombre, @Descripcion, @Precio, @Stock, @ImagenUrl, @CategoriaId)";

            using (var connection = _context.CreateConnection())
            {
                await connection.ExecuteAsync(query, producto);
            }
        }

        // 4. ACTUALIZAR PRODUCTO
        public async Task UpdateProducto(Producto producto)
        {
            var query = @"
                UPDATE productos 
                SET nombre = @Nombre, 
                    descripcion = @Descripcion, 
                    precio = @Precio, 
                    stock = @Stock, 
                    imagen_url = @ImagenUrl, 
                    categoria_id = @CategoriaId 
                WHERE id_producto = @Id";

            using (var connection = _context.CreateConnection())
            {
                await connection.ExecuteAsync(query, producto);
            }
        }

        // 5. ELIMINAR PRODUCTO
        public async Task DeleteProducto(int id)
        {
            var query = "DELETE FROM productos WHERE id_producto = @Id";

            using (var connection = _context.CreateConnection())
            {
                await connection.ExecuteAsync(query, new { Id = id });
            }
        }

        // 6. OBTENER CATEGORÍAS (Para el Dropdown/Select)
        public async Task<IEnumerable<CategoriaSelect>> ObtenerCategoriasParaSelect()
        {
            // Mapeamos id_categoria -> Id y nombre_categoria -> Nombre
            // Para que coincida con la clase CategoriaSelect que creamos en el Modelo
            var query = "SELECT id_categoria as Id, nombre_categoria as Nombre FROM categorias";

            using (var connection = _context.CreateConnection())
            {
                return await connection.QueryAsync<CategoriaSelect>(query);
            }
        }
    }
}