using AlphatechFront.Models;

namespace AlphatechFront.Interfaces
{
    public interface ICategoriaRepository
    {
        Task<IEnumerable<Categoria>> ObtenerCategorias();
        Task<Categoria> ObtenerCategoriaPorId(int id);
        Task CrearCategoria(Categoria categoria);
        Task UpdateCategoria(Categoria categoria);
        Task DeleteCategoria(int id);
    }
}