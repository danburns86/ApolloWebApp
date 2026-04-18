using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddAlternativeExits : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "NearestCallPoint",
                table: "Rooms",
                newName: "CallPoints");

            migrationBuilder.AddColumn<string>(
                name: "AlternativeExit",
                table: "Rooms",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AlternativeExit",
                table: "Rooms");

            migrationBuilder.RenameColumn(
                name: "CallPoints",
                table: "Rooms",
                newName: "NearestCallPoint");
        }
    }
}
