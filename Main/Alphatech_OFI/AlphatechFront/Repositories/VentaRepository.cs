using AlphatechFront.Models;
using Dapper;

namespace AlphatechFront.Repositories
{
    public class VentaRepository : IVentaRepository
    {
        private readonly DapperContext _context;

        public VentaRepository(DapperContext context)
        {
            _context = context;
        }

        // 1. OBTENER VENTAS (Corregido con tus columnas reales)
        public async Task<IEnumerable<Venta>> ObtenerVentas()
        {
            var query = @"
                SELECT 
                    v.id_venta as Id, 
                    v.fecha_venta as Fecha, 
                    v.total as Total, 
                    v.estado as Estado,
                    v.cupon_aplicado as CuponAplicado,
                    v.direccion_envio as DireccionEnvio,
                    -- Mapeo manual de la relación con Usuario
                    u.Id as UsuarioId, 
                    u.NombreCompleto as UsuarioNombre, 
                    u.Email as UsuarioEmail
                FROM ventas v
                INNER JOIN AspNetUsers u ON v.id_usuario = u.Id  -- AQUÍ estaba el error (id_usuario)
                ORDER BY v.fecha_venta DESC";

            using (var connection = _context.CreateConnection())
            {
                return await connection.QueryAsync<Venta>(query);
            }
        }

        // 2. OBTENER UNA VENTA POR ID (Corregido)
        public async Task<Venta> ObtenerVentaPorId(int id)
        {
            var query = @"
                SELECT 
                    v.id_venta as Id, 
                    v.fecha_venta as Fecha, 
                    v.total as Total, 
                    v.estado as Estado, 
                    v.direccion_envio as DireccionEnvio,
                    v.cupon_aplicado as CuponAplicado,
                    u.Id as UsuarioId,
                    u.NombreCompleto as UsuarioNombre, 
                    u.Email as UsuarioEmail
                FROM ventas v
                INNER JOIN AspNetUsers u ON v.id_usuario = u.Id -- Corrección: id_usuario
                WHERE v.id_venta = @Id";

            using (var connection = _context.CreateConnection())
            {
                return await connection.QuerySingleOrDefaultAsync<Venta>(query, new { Id = id });
            }
        }

        // 3. OBTENER DETALLES (Corregido tabla detalle_venta y columnas)
        public async Task<IEnumerable<DetalleVenta>> ObtenerDetallesDeVenta(int idVenta)
        {
            var query = @"
                SELECT 
                    d.cantidad as Cantidad, 
                    d.precio_unitario as PrecioUnitario,
                    p.id_producto as ProductoId,
                    p.nombre as ProductoNombre,
                    p.imagen_url as ProductoImagen
                FROM detalle_venta d  -- Corrección: nombre de tabla en singular
                INNER JOIN productos p ON d.id_producto = p.id_producto -- Corrección: id_producto
                WHERE d.id_venta = @IdVenta";

            using (var connection = _context.CreateConnection())
            {
                return await connection.QueryAsync<DetalleVenta>(query, new { IdVenta = idVenta });
            }
        }

        // 4. ACTUALIZAR ESTADO
        public async Task ActualizarEstadoVenta(int idVenta, string nuevoEstado)
        {
            var query = "UPDATE ventas SET estado = @Estado WHERE id_venta = @Id";
            using (var connection = _context.CreateConnection())
            {
                await connection.ExecuteAsync(query, new { Estado = nuevoEstado, Id = idVenta });
            }
        }
    }
}