using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class SyncProductionEventTypeAndEvent : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "CharactersRequired",
                table: "ProductionEvents",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CharactersRequired",
                table: "ProductionEvents");
        }
    }
}
