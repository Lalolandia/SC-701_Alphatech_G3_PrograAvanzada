using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AlphatechFront.Models
{
    [Table("productos", Schema = "dbo")]
    public class Producto
    {
        [Key]
        [Column("id_producto")]
        public int id_producto { get; set; }

        [Column("nombre")]
        public string nombre { get; set; }

        [Column("descripcion")]
        public string descripcion { get; set; }

        [Column("precio")]
        public decimal precio { get; set; }

        [Column("stock")]
        public int stock { get; set; }

        [Column("imagen_url")]
        public string imagen_url { get; set; }

        [Column("categoria_id")]
        public int? categoria_id { get; set; }
    }
}
