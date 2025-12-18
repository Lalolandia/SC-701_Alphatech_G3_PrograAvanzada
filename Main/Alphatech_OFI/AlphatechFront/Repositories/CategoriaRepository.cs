using AlphatechFront.Data;
using AlphatechFront.Interfaces;
using AlphatechFront.Models;
using Dapper;

namespace AlphatechFront.Repositories
{
    public class CategoriaRepository : ICategoriaRepository
    {
        private readonly DapperContext _context;

        public CategoriaRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Categoria>> ObtenerCategorias()
        {
            var query = "SELECT id_categoria as Id, nombre_categoria as Nombre FROM categorias";
            using (var connection = _context.CreateConnection())
            {
                return await connection.QueryAsync<Categoria>(query);
            }
        }

        public async Task<Categoria> ObtenerCategoriaPorId(int id)
        {
            var query = "SELECT id_categoria as Id, nombre_categoria as Nombre FROM categorias WHERE id_categoria = @Id";
            using (var connection = _context.CreateConnection())
            {
                return await connection.QuerySingleOrDefaultAsync<Categoria>(query, new { Id = id });
            }
        }

        public async Task CrearCategoria(Categoria categoria)
        {
            var query = "INSERT INTO categorias (nombre_categoria) VALUES (@Nombre)";
            using (var connection = _context.CreateConnection())
            {
                await connection.ExecuteAsync(query, categoria);
            }
        }

        public async Task UpdateCategoria(Categoria categoria)
        {
            var query = "UPDATE categorias SET nombre_categoria = @Nombre WHERE id_categoria = @Id";
            using (var connection = _context.CreateConnection())
            {
                await connection.ExecuteAsync(query, categoria);
            }
        }

        public async Task DeleteCategoria(int id)
        {
            // OJO: Si borras una categoría que tiene productos, podría dar error de llave foránea.
            // Para este ejemplo simple asumimos que se puede borrar.
            var query = "DELETE FROM categorias WHERE id_categoria = @Id";
            using (var connection = _context.CreateConnection())
            {
                await connection.ExecuteAsync(query, new { Id = id });
            }
        }
    }
}