// Data/DapperContext.cs
using System.Data;
using Microsoft.Data.SqlClient;

public class DapperContext
{
    private readonly IConfiguration _configuration;
    private readonly string _connectionString;

    public DapperContext(IConfiguration configuration)
    {
        _configuration = configuration;
        // Asegúrate que en tu appsettings.json tu cadena se llame "DefaultConnection"
        _connectionString = _configuration.GetConnectionString("DefaultConnection");
    }

    public IDbConnection CreateConnection()
        => new SqlConnection(_connectionString);
}